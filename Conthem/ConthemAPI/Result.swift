//
//  Result.swift
//  Conthem
//
//  Created by René Sandoval on 07/08/22.
//

extension Result {
    init(value: Success?, failWith error: @autoclosure () -> Failure) {
        if let value = value {
            self = .success(value)
        } else {
            self = .failure(error())
        }
    }

    public var value: Success? {
        switch self {
        case let .success(value):
            return value
        case .failure:
            return nil
        }
    }

    public var error: Failure? {
        switch self {
        case .success:
            return nil
        case let .failure(error):
            return error
        }
    }
}
