//
//  InstructionsDialog.swift
//  Conthem
//
//  Created by René Sandoval on 08/08/22.
//

import UIKit

class InstructionsDialog: GenericDialog {
    private lazy var descriptionTextLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Texts.ContactsView.instructionsLabel
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    override private init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupView() {
        containerView.heightAnchor(equalTo: heightAnchor, multiplier: 0.25)
        containerView.addSubview(descriptionTextLabel)
        
        descriptionTextLabel.widthAnchor(equalTo: widthAnchor, multiplier: 0.80)
        descriptionTextLabel.centerXAnchor(equalTo: containerView.centerXAnchor)
        descriptionTextLabel.centerYAnchor(equalTo: containerView.centerYAnchor)
    }
}
