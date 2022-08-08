//
//  APIRoute.swift
//  Conthem
//
//  Created by René Sandoval on 07/08/22.
//

import Foundation

enum APIRoute {
    static var baseURL = URL(staticString: "https://randomuser.me")

    case contacts(country: String, gender: String)
}

extension APIRoute: Routable {
    var url: URL {
        let path: String = {
            switch self {
            case let .contacts(country: country, gender: gender):
                return "/api/?nat=\(country)&gender=\(gender)&results=50"
            }
        }()

        return URL(string: path, relativeTo: APIRoute.baseURL)!
    }

    var extraHTTPHeaders: [String: String] {
        var extraHeaders: [String: String] = [:]
        extraHeaders["Content-Type"] = "application/json"

        return extraHeaders
    }
}
