//
//  CountryCollectionViewCell.swift
//  Conthem
//
//  Created by René Sandoval on 06/08/22.
//

import UIKit

class CountryCollectionViewCell: UICollectionViewCell {
    static let id = "CountryCollectionViewCell"

    lazy var countryImageView: UIImageView = UIImageView()
    lazy var countryLabel: UILabel = UILabel()

    override var isSelected: Bool {
        didSet {
            countryLabel.font = isSelected ? .systemFont(ofSize: 15, weight: .bold) : .systemFont(ofSize: 14, weight: .light)
            countryLabel.backgroundColor = isSelected ? .main : .white
            countryLabel.textColor = isSelected ? .white : .secondary
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .clear
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 12

        countryImageView.contentMode = .scaleAspectFit
        countryImageView.backgroundColor = .clear

        countryLabel.font = .systemFont(ofSize: 14, weight: .regular)
        countryLabel.textColor = .secondary
        countryLabel.textAlignment = .center

        setupLayoutViews()
    }

    func setupLayoutViews() {
        [countryImageView, countryLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        countryImageView.leadingAnchor(equalTo: contentView.leadingAnchor)
        countryImageView.topAnchor(equalTo: contentView.topAnchor)
        countryImageView.trailingAnchor(equalTo: contentView.trailingAnchor)
        countryImageView.bottomAnchor(equalTo: contentView.bottomAnchor)

        countryLabel.centerXAnchor(equalTo: contentView.centerXAnchor)
        countryLabel.centerYAnchor(equalTo: contentView.centerYAnchor, constant: 12.5)
        countryLabel.backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with country: Country) {
        countryLabel.text = country.country
        countryImageView.downloaded(from: Constants.Api.countryflags + country.country.lowercased())
    }

    func setSelectedStyle() {
        countryLabel.font = .systemFont(ofSize: 15, weight: .bold)
        countryLabel.backgroundColor = .main
        countryLabel.textColor = .white
    }
}
