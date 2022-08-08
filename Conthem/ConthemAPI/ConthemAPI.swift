//
//  ConthemAPI.swift
//  Conthem
//
//  Created by René Sandoval on 07/08/22.
//

import CoreLocation

private let kRequestTimeout = 20.0

struct ConthemAPI {
    static let client: HTTPClient = {
        var configuration = URLSessionConfiguration.ephemeral
        configuration.timeoutIntervalForRequest = kRequestTimeout

        return HTTPClient(configuration: configuration)
    }()
}

extension ConthemAPI {
    static func getContacts(resultsRequestModel: ContactsRequestModel, completion: @escaping (Result<[ContactsResponseModel], ConthemAPIError>) -> Void)
    {
        client.request(.get, APIRoute.contacts(country: resultsRequestModel.country, gender: resultsRequestModel.gender)) { responseObject, status in
            let response = responseObject as? NSDictionary
            let error = ConthemAPIError(response: response, status: status) ?? .UnknownError
            let results = [ContactsResponseModel](json: response?["results"])
            completion(Result(value: results, failWith: error))
        }
    }
}
