//
//  ContactsPresenter.swift
//  Conthem
//
//  Created by René Sandoval on 05/08/22.
//

class ContactsPresenter: ContactsOutput {
    weak var view: ContactsView?
    var provider: ContactsProvider?
    var wireframe: ContactsWireFrame?
    var countries: [Country] = []
    var contacts: [ContactsResponseModel] = []

    func contactsResponse<T>(response: T) {
        switch response {
        case is [ContactsResponseModel]:
            groupContacts(contacts: response as! [ContactsResponseModel])
        case is String:
            view?.contactsResponseFail(response: response as! String)
            break
        default:
            break
        }
    }
}

extension ContactsPresenter: ContactsEventHandler {
    func getContacts(requestModel: ContactsRequestModel) {
        provider?.contactsRequest(requestModel: requestModel)
    }

    private func groupContacts(contacts: [ContactsResponseModel]) {
        countries.removeAll()
        self.contacts.removeAll()
        self.contacts = contacts
        Dictionary(grouping: contacts, by: { (element: ContactsResponseModel) in
            element.nat
        }).forEach { (_: String, value: [ContactsResponseModel]) in
            countries.append(Country(code: value.first?.nat ?? "", country: value.first?.location.country ?? "", contacts: value))
        }

        countries.sort { $0.country < $1.country }
        self.contacts.sort { $0.name.first < $1.name.first }
        view?.contactsResponseSuccess(response: self.contacts, countries: countries)
    }
}
