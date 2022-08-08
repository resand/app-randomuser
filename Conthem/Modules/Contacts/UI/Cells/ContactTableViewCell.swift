//
//  ContactTableViewCell.swift
//  Conthem
//
//  Created by René Sandoval on 07/08/22.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    static let id = "ContactTableViewCell"

    lazy var userImageView: UIImageView = UIImageView()
    lazy var nameLabel: UILabel = UILabel()
    lazy var emailLabel: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .clear

        contentView.backgroundColor = .white
        backgroundColor = .white
        setupLayoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        contentView.roundCorners()
        
        contentView.layer.shadowColor = UIColor.darkText.withAlphaComponent(0.8).cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowRadius = 4.0
        contentView.layer.masksToBounds = false
        contentView.layer.cornerRadius = 12.5
    }

    func setupLayoutViews() {
        [userImageView, nameLabel, emailLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        userImageView.leadingAnchor(equalTo: contentView.leadingAnchor, constant: 7.5)
        userImageView.centerYAnchor(equalTo: contentView.centerYAnchor)
        userImageView.widthAnchor(equalTo: 60)
        userImageView.heightAnchor(equalTo: 60)

        nameLabel.centerYAnchor(equalTo: contentView.centerYAnchor, constant: -9)
        nameLabel.leadingAnchor(equalTo: userImageView.trailingAnchor, constant: 10)
        nameLabel.trailingAnchor(equalTo: contentView.trailingAnchor, constant: -10)
        nameLabel.widthAnchor(equalTo: frame.size.width - 170)

        emailLabel.centerYAnchor(equalTo: contentView.centerYAnchor, constant: 9)
        emailLabel.leadingAnchor(equalTo: userImageView.trailingAnchor, constant: 10)
        emailLabel.trailingAnchor(equalTo: contentView.trailingAnchor, constant: -10)
        emailLabel.widthAnchor(equalTo: frame.size.width - 170)
        emailLabel.heightAnchor(equalTo: 25)
    }

    func setup(contact: ContactsResponseModel) {
        userImageView.downloaded(from: contact.picture.large)
        userImageView.contentMode = .scaleAspectFit
        userImageView.layer.cornerRadius = 30
        userImageView.clipsToBounds = true

        nameLabel.text = "\(contact.name.first) \(contact.name.last)"
        nameLabel.textColor = .main
        nameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        nameLabel.frame.size = nameLabel.intrinsicContentSize

        emailLabel.text = contact.email
        emailLabel.textColor = .secondary
        emailLabel.font = .systemFont(ofSize: 14, weight: .regular)
        emailLabel.frame.size = emailLabel.intrinsicContentSize
    }
}
