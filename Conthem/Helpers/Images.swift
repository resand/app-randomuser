//
//  Images.swift
//  Conthem
//
//  Created by René Sandoval on 07/08/22.
//

import UIKit

final class Images {
    var rawValue: String

    init(_ value: String) {
        rawValue = value
    }

    func image() -> UIImage? {
        return UIImage(named: rawValue, in: Bundle.main, compatibleWith: nil)
    }
}

extension Images {
    static let gendersIcon = Images("gendersIcon")
    static let femaleIcon = Images("femaleIcon")
    static let maleIcon = Images("maleIcon")
}
