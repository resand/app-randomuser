//
//  Constants.swift
//  Conthem
//
//  Created by René Sandoval on 05/08/22.
//

struct Constants {
    struct App {
        static let name = "Conthem"
    }

    struct Texts {
        struct Alerts {
            static let buttonOk = "Ok"
            static let buttonCancel = "Cancel"
        }

        struct ContactsView {
            static let buttonReset = "Reset country"
            static let instructionsLabel = "Choose a country or gender to search for contacts and refresh the table by pulling to refresh."
        }
    }

    struct Animations {
        static let splash = "splash.json"
        static let loader = "loader.json"
    }

    struct Api {
        static let contacts = "https://randomuser.me/api/?"
        static let countryflags = "https://countryflagsapi.com/png/"
    }

    struct Errors {
        static let serviceError = "Ocurrio un error al obtener los contactos, intente nuevamente."
    }
}
