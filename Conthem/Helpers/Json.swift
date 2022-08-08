//
//  Json.swift
//  Conthem
//
//  Created by René Sandoval on 07/08/22.
//

import Foundation

final class JSON: Sequence, CustomStringConvertible {
    private var json: Any

    var description: String {
        if let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) as Data {
            if let description = String(data: data, encoding: String.Encoding.utf8) {
                return description
            } else {
                return String(describing: json)
            }
        } else {
            return String(describing: json)
        }
    }

    // MARK: - Initializers

    init(from any: Any) {
        json = any
    }

    subscript(path: String) -> JSON? {
        guard var jsonDict = self.json as? [String: AnyObject] else {
            return nil
        }

        var json = self.json
        let pathArray = path.components(separatedBy: ".")

        for key in pathArray {
            if let jsonObject = jsonDict[key] {
                json = jsonObject

                if let jsonDictNext = jsonObject as? [String: AnyObject] {
                    jsonDict = jsonDictNext
                }
            } else {
                return nil
            }
        }

        return JSON(from: json)
    }

    subscript(index: Int) -> JSON? {
        guard let array = json as? [AnyObject], array.count > index else { return nil }
        return JSON(from: array[index])
    }

    class func dataToJson(_ data: Data) throws -> JSON {
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        let json = JSON(from: jsonObject as AnyObject)

        return json
    }

    // MARK: - Public methods

    func toData() -> Data? {
        do {
            let data = try JSONSerialization.data(withJSONObject: json)
            return data
        } catch let error as NSError {
            logError(error)
            return nil
        }
    }

    func toBool() -> Bool? {
        return json as? Bool
    }

    func toInt() -> Int? {
        if let value = json as? Int {
            return value
        } else if let value = toString() {
            return Int(value)
        }

        return nil
    }

    func toString() -> String? {
        return json as? String
    }

    func toDouble() -> Double? {
        return json as? Double
    }

    func toDictionary() -> [String: Any]? {
        guard let dic = json as? [String: Any] else {
            return [:]
        }

        return dic
    }

    // MARK: - Sequence Methods

    func makeIterator() -> AnyIterator<JSON> {
        var index = 0

        return AnyIterator { () -> JSON? in
            guard let array = self.json as? [AnyObject] else { return nil }
            guard array.count > index else { return nil }

            let item = array[index]
            let json = JSON(from: item)
            index += 1

            return json
        }
    }
}
