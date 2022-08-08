//
//  BaseViewController.swift
//  Conthem
//
//  Created by René Sandoval on 05/08/22.
//

import UIKit

open class BaseViewController: UIViewController, Customizable {
    open func setup() {}
    open func setupAppearance() { view.setNeedsLayout() }
    open func setupLayout() { view.setNeedsLayout() }
    open func updateContent() { view.setNeedsLayout() }

    override open func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupLayout()
        setupAppearance()
        updateContent()
    }

    func showAlert(_ message: String, context: UIViewController) {
        let alert = UIAlertController(title: Constants.App.name, message: message, preferredStyle: .alert)

        let actionLater = UIAlertAction(title: Constants.Texts.Alerts.buttonOk, style: .cancel, handler: nil)
        alert.addAction(actionLater)

        context.present(alert, animated: true, completion: nil)
    }

    func connectionStatus() -> Bool {
        let status = Reach().connectionStatus()

        switch status {
        case .unknown, .offline:
            return false
        case .online(.wwan):
            return true
        case .online(.wiFi):
            return true
        }
    }

    func startLoader() {
        LoadingIndicatorView.show("Loading")
    }
    func stopLoader() {
        LoadingIndicatorView.hide()
    }

    func localHideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
