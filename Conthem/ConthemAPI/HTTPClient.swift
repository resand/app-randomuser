//
//  HTTPClient.swift
//  Conthem
//
//  Created by René Sandoval on 07/08/22.
//

import Foundation

private let kErrorMap: [Int: ResponseType] = [
    400: .badRequest,
    401: .unauthorized,
    403: .forbidden,
    404: .notFound,
    408: .requestTimeOut,
    409: .conflict,
    410: .gone,
    422: .unprocessable,
    426: .upgradeRequired,
    500: .internalError,
    502: .badGateway,
    503: .serviceUnavailable,
    504: .gatewayTimeOut,
    NSURLErrorCancelled: .canceled,
    NSURLErrorTimedOut: .clientTimeOut,
    NSURLErrorNotConnectedToInternet: .notConnected,
]

protocol Routable {
    var url: URL { get }
    var extraHTTPHeaders: [String: String] { get }
}

enum HTTPMethod: String {
    case options, get, head, post, put, patch, delete, trace, connect
}

public enum ResponseType {
    case succeed
    case badRequest, unauthorized, upgradeRequired, forbidden, gone
    case canceled, unprocessable, notFound, unknownError, clientTimeOut, notConnected
    case conflict, internalError, badGateway, serviceUnavailable, requestTimeOut, gatewayTimeOut

    init(fromCode code: Int) {
        if code >= 200 && code < 300 {
            self = .succeed
            return
        }

        self = kErrorMap[code] ?? .unknownError
    }
}

final class HTTPClient {
    private let session: URLSession

    required init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        session = URLSession(configuration: configuration)
    }

    func request(_ method: HTTPMethod, _ route: Routable, parameters: [String: Any]? = nil,
                 completion: @escaping (Any?, ResponseType) -> Void) {
        let request = urlRequest(method: method, route: route, parameters: parameters)

        let dataTask = session.dataTask(with: request) { data, response, error in
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 500
            var status: ResponseType
            let JSON = try? JSONSerialization.jsonObject(with: data ?? Data(), options: [])

            if let error = error as? NSError {
                self.logResponseError(response: response as? HTTPURLResponse, error)
                status = ResponseType(fromCode: error.code)
                DispatchQueue.main.async {
                    completion(JSON, status)
                }
            } else {
                status = ResponseType(fromCode: statusCode)
                self.logResponse(response as? HTTPURLResponse, data)
                DispatchQueue.main.async {
                    completion(JSON, status)
                }
            }
        }

        dataTask.resume()
    }

    private func urlRequest(method: HTTPMethod, route: Routable,
                            parameters: [String: Any]? = nil) -> URLRequest {
        var request = URLRequest(url: route.url)
        request.httpMethod = method.rawValue

        for (key, value) in route.extraHTTPHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }

        return conthemURLEncodedInURL(request: request, parameters: parameters).0
    }
}

// MARK: - Logs

extension HTTPClient {
    fileprivate func logRequest(_ request: URLRequest?) {
        if ConthemConfiguration.shared.logLevel != .debug {
            return
        }

        let url = request?.url?.absoluteString ?? "INVALID URL"

        log("******** REQUEST ********")
        log(" - URL:\t" + url)
        log(" - METHOD:\t" + (request?.httpMethod ?? "INVALID REQUEST"))
        logHeaders(request)
        logBody(request)
        log("*************************\n")
    }

    fileprivate func logBody(_ request: URLRequest?) {
        guard
            let body = request?.httpBody,
            let json = try? JSON.dataToJson(body)
        else { return }

        log(" - BODY:\n\(json)")
    }

    fileprivate func logHeaders(_ request: URLRequest?) {
        guard let headers = request?.allHTTPHeaderFields else { return }

        log(" - HEADERS: {")

        for key in headers.keys {
            if let value = headers[key] {
                log("\t\t\(key): \(value)")
            }
        }

        log("}")
    }

    fileprivate func logResponse(_ response: HTTPURLResponse?, _ data: Data?) {
        guard ConthemConfiguration.shared.logLevel == .debug else { return }

        log("******** RESPONSE ********")
        log(" - URL:\t" + logURL(response))
        log(" - CODE:\t" + "\(response?.statusCode ?? -1)")
        logHeaders(response)
        log(" - DATA:\n" + logData(data))
        log("*************************\n")
    }

    fileprivate func logResponseError(response: HTTPURLResponse?, _ error: NSError?) {
        guard ConthemConfiguration.shared.logLevel == .debug else { return }

        log("******** ERROR ********")
        log(" - URL:\t" + logURL(response))
        log(" - CODE:\t" + "\(error?.code ?? -1)")
        logHeaders(response)
        log(" - MESSAGE:\t" + "\(error?.localizedDescription ?? "")")
        log("*************************\n")
    }

    fileprivate func logURL(_ response: HTTPURLResponse?) -> String {
        guard let url = response?.url?.absoluteString else {
            return "NO URL"
        }

        return url
    }

    fileprivate func logHeaders(_ response: HTTPURLResponse?) {
        guard let headers = response?.allHeaderFields else { return }

        log(" - HEADERS: {")

        for key in headers.keys {
            if let value = headers[key] {
                log("\t\t\(key): \(value)")
            }
        }

        log("}")
    }

    fileprivate func logData(_ data: Data?) -> String {
        guard let data = data else {
            return "NO DATA"
        }

        guard let dataJson = try? JSON.dataToJson(data) else {
            return String(data: data, encoding: String.Encoding.utf8) ?? "Error parsing JSON"
        }

        return "\(dataJson)"
    }
}
