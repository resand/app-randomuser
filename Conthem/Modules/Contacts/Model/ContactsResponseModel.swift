//
//  ContactsResponseModel.swift
//  Conthem
//
//  Created by René Sandoval on 07/08/22.
//

import Foundation

struct ContactsResponseModel {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob: Dob
    let registered: Registered
    let phone, cell: String
    let id: ID
    let picture: Picture
    let nat: String
}

extension ContactsResponseModel: JSONMappable {
    init?(json: NSDictionary) {
        guard let gender = json["gender"] as? String,
              let name = Name(json: json["name"]),
              let location = Location(json: json["location"]),
              let email = json["email"] as? String,
              let login = Login(json: json["login"]),
              let dob = Dob(json: json["dob"]),
              let registered = Registered(json: json["registered"]),
              let phone = json["phone"] as? String,
              let cell = json["cell"] as? String,
              let id = ID(json: json["id"]),
              let picture = Picture(json: json["picture"]),
              let nat = json["nat"] as? String else {
            return nil
        }

        self.gender = gender
        self.name = name
        self.location = location
        self.email = email
        self.login = login
        self.dob = dob
        self.registered = registered
        self.phone = phone
        self.cell = cell
        self.id = id
        self.picture = picture
        self.nat = nat
    }
}

struct Name: Codable {
    let title, first, last: String
}

extension Name: JSONMappable {
    init?(json: NSDictionary) {
        guard let title = json["title"] as? String,
              let first = json["first"] as? String,
              let last = json["last"] as? String else {
            return nil
        }

        self.title = title
        self.first = first
        self.last = last
    }
}

struct Location: Codable {
    let street: Street
    let city, state, country: String
    let postcode: Int
    let coordinates: Coordinates
    let timezone: Timezone
}

extension Location: JSONMappable {
    init?(json: NSDictionary) {
        guard let street = Street(json: json["street"]),
              let city = json["city"] as? String,
              let state = json["state"] as? String,
              let country = json["country"] as? String,
              let postcode = json["postcode"] as? Int,
              let coordinates = Coordinates(json: json["coordinates"]),
              let timezone = Timezone(json: json["timezone"]) else {
            return nil
        }

        self.street = street
        self.city = city
        self.state = state
        self.country = country
        self.postcode = postcode
        self.coordinates = coordinates
        self.timezone = timezone
    }
}

struct Street: Codable {
    let number: Int
    let name: String
}

extension Street: JSONMappable {
    init?(json: NSDictionary) {
        guard let number = json["number"] as? Int,
              let name = json["name"] as? String else {
            return nil
        }

        self.number = number
        self.name = name
    }
}

struct Coordinates: Codable {
    let latitude, longitude: String
}

extension Coordinates: JSONMappable {
    init?(json: NSDictionary) {
        guard let latitude = json["latitude"] as? String,
              let longitude = json["longitude"] as? String else {
            return nil
        }

        self.latitude = latitude
        self.longitude = longitude
    }
}

struct Timezone: Codable {
    let offset, timezoneDescription: String

    enum CodingKeys: String, CodingKey {
        case offset
        case timezoneDescription = "description"
    }
}

extension Timezone: JSONMappable {
    init?(json: NSDictionary) {
        guard let offset = json["offset"] as? String,
              let timezoneDescription = json["description"] as? String else {
            return nil
        }

        self.offset = offset
        self.timezoneDescription = timezoneDescription
    }
}

struct Login: Codable {
    let uuid, username, password, salt: String
    let md5, sha1, sha256: String
}

extension Login: JSONMappable {
    init?(json: NSDictionary) {
        guard let uuid = json["uuid"] as? String,
              let username = json["username"] as? String,
              let password = json["password"] as? String,
              let salt = json["salt"] as? String,
              let md5 = json["md5"] as? String,
              let sha1 = json["sha1"] as? String,
              let sha256 = json["sha256"] as? String else {
            return nil
        }

        self.uuid = uuid
        self.username = username
        self.password = password
        self.salt = salt
        self.md5 = md5
        self.sha1 = sha1
        self.sha256 = sha256
    }
}

struct Dob: Codable {
    let date: String
    let age: Int
}

extension Dob: JSONMappable {
    init?(json: NSDictionary) {
        guard let date = json["date"] as? String,
              let age = json["age"] as? Int else {
            return nil
        }

        self.date = date
        self.age = age
    }
}

struct Registered: Codable {
    let date: String
    let age: Int
}

extension Registered: JSONMappable {
    init?(json: NSDictionary) {
        guard let date = json["date"] as? String,
              let age = json["age"] as? Int else {
            return nil
        }

        self.date = date
        self.age = age
    }
}

struct ID: Codable {
    let name: String
    let value: String?
}

extension ID: JSONMappable {
    init?(json: NSDictionary) {
        guard let name = json["name"] as? String,
              let value = json["value"] as? String else {
            return nil
        }

        self.name = name
        self.value = value
    }
}

struct Picture: Codable {
    let large, medium, thumbnail: String
}

extension Picture: JSONMappable {
    init?(json: NSDictionary) {
        guard let large = json["large"] as? String,
              let medium = json["medium"] as? String,
              let thumbnail = json["thumbnail"] as? String else {
            return nil
        }

        self.large = large
        self.medium = medium
        self.thumbnail = thumbnail
    }
}
