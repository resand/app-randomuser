//
//  ConthemAPIError.swift
//  Conthem
//
//  Created by René Sandoval on 07/08/22.
//

import Foundation

public struct ConthemAPIError: Error {
    public let message: String?
    public let reason: String
    public let status: ResponseType?

    static let UnknownError = ConthemAPIError("unknown")

    init(_ reason: String, message: String? = nil) {
        self.reason = reason
        self.message = message
        status = nil
    }

    init?(response: NSDictionary?, status: ResponseType) {
        self.status = status

        if status == .succeed {
            return nil
        }

        reason = response?["error"] as? String ?? ConthemAPIError.UnknownError.reason
        message = response?["error_description"] as? String
    }
}
