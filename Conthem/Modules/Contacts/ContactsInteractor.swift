//
//  ContactsInteractor.swift
//  Conthem
//
//  Created by René Sandoval on 05/08/22.
//

import Foundation

class ContactsInteractor: ContactsProvider {
    weak var output: ContactsOutput?

    func contactsRequest(requestModel: ContactsRequestModel) {
        ConthemAPI.getContacts(resultsRequestModel: requestModel) { result in
            if let error = result.error {
                self.output?.contactsResponse(response: error.message ?? "")
            }

            self.output?.contactsResponse(response: result.value)
        }
    }
}
