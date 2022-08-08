//
//  ContactsWireFrame.swift
//  Conthem
//
//  Created by René Sandoval on 05/08/22.
//

import UIKit

class ContactsWireFrame {
    private var view: ContactsViewController?
    private let presenter: ContactsPresenter?
    private let interactor: ContactsInteractor?
    private var window: UIWindow?

    init(in window: UIWindow?) {
        view = ContactsViewController()
        presenter = ContactsPresenter()
        interactor = ContactsInteractor()

        view?.eventHandler = presenter
        presenter?.view = view
        presenter?.provider = interactor
        interactor?.output = presenter
        presenter?.wireframe = self
        self.window = window
    }

    func rootMovementViewController() {
        window?.rootViewController = UINavigationController(rootViewController: view!)
        window?.makeKeyAndVisible()
    }
}
