//
//  JSONMappable.swift
//  Conthem
//
//  Created by René Sandoval on 07/08/22.
//

import Foundation

protocol JSONMappable {
    init?(json: NSDictionary)
    init?(json: Any?)
}

extension JSONMappable {
    init?(json: Any?) {
        if let json = json as? NSDictionary {
            self.init(json: json)
        } else {
            return nil
        }
    }
}

extension Array where Element: JSONMappable {
    init?(json: Any?) {
        if let json = json as? [NSDictionary], json.count > 0 {
            self = json.compactMap { Element(json: $0) }
        } else {
            return nil
        }
    }
}
