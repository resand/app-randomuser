//
//  ContactsInterface.swift
//  Conthem
//
//  Created by René Sandoval on 05/08/22.
//

import UIKit

protocol ContactsView: AnyObject {
    func contactsResponseSuccess(response: [ContactsResponseModel], countries: [Country])
    func contactsResponseFail(response: String)
}

protocol ContactsEventHandler {
    func getContacts(requestModel: ContactsRequestModel)
}

protocol ContactsOutput: AnyObject {
    func contactsResponse<T>(response: T)
}

protocol ContactsProvider {
    func contactsRequest(requestModel: ContactsRequestModel)
}
