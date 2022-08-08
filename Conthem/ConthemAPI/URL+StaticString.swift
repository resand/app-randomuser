//
//  URL+StaticString.swift
//  Conthem
//
//  Created by René Sandoval on 07/08/22.
//

import Foundation

extension URL {
    init(staticString: StaticString) {
        self.init(string: String(describing: staticString))!
    }
}
