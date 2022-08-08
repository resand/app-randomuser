//
//  ContactsViewController.swift
//  Conthem
//
//  Created by René Sandoval on 05/08/22.
//

import UIKit

class ContactsViewController: BaseViewController {
    var eventHandler: ContactsEventHandler?
    private var contactsRequestModel: ContactsRequestModel!

    private lazy var instructionsDialog: InstructionsDialog = InstructionsDialog()
    private lazy var contactsListView: ContactsListView = ContactsListView()

    private var instructionsShowed: Bool = false

    override func setup() {
        contactsListView.delegate = self

        guard connectionStatus() else {
            showAlert("No tienes conexión a Internet.", context: self)
            return
        }

        startLoader()
        contactsRequestModel = ContactsRequestModel(country: "", gender: Gender.both.rawValue.lowercased())
        eventHandler?.getContacts(requestModel: contactsRequestModel)
    }

    override func setupAppearance() {
        view.backgroundColor = .red
    }

    override func setupLayout() {
        view.addSubview(contactsListView)
        contactsListView.translatesAutoresizingMaskIntoConstraints = false

        contactsListView.leadingAnchor(equalTo: view.leadingAnchor)
        contactsListView.topAnchor(equalTo: view.topAnchor)
        contactsListView.trailingAnchor(equalTo: view.trailingAnchor)
        contactsListView.bottomAnchor(equalTo: view.bottomAnchor)

        view.addSubview(instructionsDialog)
        let screenSize: CGRect = UIScreen.main.bounds
        instructionsDialog.frame = screenSize
    }
}

// MARK: - Internal methods

extension ContactsViewController {
    private func showHideInstructionsDialog() {
        guard !instructionsShowed else {
            return
        }

        instructionsShowed = true
        instructionsDialog.show()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.instructionsDialog.hide()
        }
    }
}
extension ContactsViewController: ContactsView {
    func contactsResponseSuccess(response: [ContactsResponseModel], countries: [Country]) {
        stopLoader()
        contactsListView.setData(countries: countries, contacts: response)
        showHideInstructionsDialog()
    }

    func contactsResponseFail(response: String) {
        stopLoader()
        logWarn(response)
    }
}

// MARK: - Delegate ContactsListView

extension ContactsViewController: ContactsListViewDelegate {
    func countrySelected(country: Country) {
        startLoader()
        contactsRequestModel.country = country.code.lowercased()
        eventHandler?.getContacts(requestModel: contactsRequestModel)
    }

    func genderSelected(gender: Gender) {
        startLoader()
        contactsRequestModel.gender = gender.rawValue.lowercased()
        eventHandler?.getContacts(requestModel: contactsRequestModel)
    }

    func contactSelected(contact: ContactsResponseModel) {
        logInfo("\(contact.name.first) selected")
    }

    func refreshTableView() {
        startLoader()
        eventHandler?.getContacts(requestModel: contactsRequestModel)
    }
}
