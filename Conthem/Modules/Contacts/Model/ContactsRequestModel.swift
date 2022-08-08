//
//  ContactsRequestModel.swift
//  Conthem
//
//  Created by René Sandoval on 05/08/22.
//

struct ContactsRequestModel {
    var country: String
    var gender: String
    var results: Int!

    func toDictionary() -> [String: Any] {
        var data: [String: Any] = [:]
        data["nat"] = country
        data["gender"] = gender
        data["results"] = 30

        return data
    }
}
