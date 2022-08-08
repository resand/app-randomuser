//
//  ContactsListView.swift
//  Conthem
//
//  Created by René Sandoval on 06/08/22.
//

import UIKit

final class ContactsListView: BaseView {
    private var collectionViewCountries: UICollectionView!
    private var resetButton: UIButton = UIButton(type: .system)
    private let segmentControlGender = UISegmentedControl(items: [Images.gendersIcon.image()!, Images.femaleIcon.image()!, Images.maleIcon.image()!])
    private var tableViewContacts: UITableView = UITableView()
    private let refreshControl = UIRefreshControl()

    private var countries: [Country] = []
    private var contacts: [ContactsResponseModel] = []

    weak var delegate: ContactsListViewDelegate?

    public func setData(countries: [Country], contacts: [ContactsResponseModel]) {
        self.countries.removeAll()
        self.contacts.removeAll()
        self.countries = countries
        self.contacts = contacts

        collectionViewCountries.reloadData()
        tableViewContacts.reloadData()

        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }

        [collectionViewCountries, segmentControlGender, tableViewContacts].forEach { $0?.isHidden = false }
        resetButton.isHidden = countries.count == 1 ? false : true

        AnimateIn { self.layoutIfNeeded() }
    }

    override func setup() {
        setupCollectionViewCountries()
        setupResetButton()
        setupSegmentedControl()
        setupTableViewContacts()
    }

    override func setupAppearance() {
        backgroundColor = .white

        [collectionViewCountries].forEach {
            $0.backgroundColor = .white
        }

        segmentControlGender.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)], for: .normal)
    }

    override func setupLayout() {
        [collectionViewCountries, resetButton, segmentControlGender, tableViewContacts].forEach {
            addSubview($0!)
            $0!.translatesAutoresizingMaskIntoConstraints = false
        }

        collectionViewCountries.topAnchor(equalTo: safeTopAnchor)
        collectionViewCountries.leadingAnchor(equalTo: leadingAnchor, constant: 20)
        collectionViewCountries.trailingAnchor(equalTo: trailingAnchor, constant: -20)
        collectionViewCountries.heightAnchor(equalTo: 40)

        resetButton.topAnchor(equalTo: collectionViewCountries.bottomAnchor, constant: 5)
        resetButton.leadingAnchor(equalTo: collectionViewCountries.leadingAnchor)
        resetButton.widthAnchor(equalTo: 100)
        resetButton.heightAnchor(equalTo: 20)

        segmentControlGender.topAnchor(equalTo: resetButton.bottomAnchor, constant: 10)
        segmentControlGender.leadingAnchor(equalTo: leadingAnchor, constant: 20)
        segmentControlGender.trailingAnchor(equalTo: trailingAnchor, constant: -20)
        segmentControlGender.heightAnchor(equalTo: 40)

        tableViewContacts.topAnchor(equalTo: segmentControlGender.bottomAnchor, constant: 20)
        tableViewContacts.leadingAnchor(equalTo: leadingAnchor, constant: 20)
        tableViewContacts.trailingAnchor(equalTo: trailingAnchor, constant: -20)
        tableViewContacts.bottomAnchor(equalTo: safeBottomAnchor)

        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableViewContacts.addSubview(refreshControl)
    }
}

// MARK: Internal methods

extension ContactsListView {
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        var selectedGender: Gender!

        switch sender.selectedSegmentIndex {
        case 0:
            selectedGender = Gender.both
            break
        case 1:
            selectedGender = Gender.male
            break
        default:
            selectedGender = Gender.female
        }

        delegate?.genderSelected(gender: selectedGender)
    }

    @objc private func refresh() {
        delegate?.refreshTableView()
    }

    @objc private func resetCountry() {
        delegate?.countrySelected(country: Country(code: "", country: "", contacts: []))
    }
}

// MARK: Setup Views

extension ContactsListView {
    private func setupCollectionViewCountries() {
        // Layouts
        let horizontalLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        horizontalLayout.scrollDirection = .horizontal

        // Options Collection View
        collectionViewCountries = UICollectionView(frame: CGRect.zero, collectionViewLayout: horizontalLayout)

        collectionViewCountries.isHidden = true
        collectionViewCountries.register(CountryCollectionViewCell.self, forCellWithReuseIdentifier: CountryCollectionViewCell.id)
        collectionViewCountries.showsHorizontalScrollIndicator = false
        collectionViewCountries.showsVerticalScrollIndicator = false
        collectionViewCountries.dataSource = self
        collectionViewCountries.delegate = self
    }

    private func setupResetButton() {
        resetButton.isHidden = true
        resetButton.contentHorizontalAlignment = .left
        resetButton.setTitle(Constants.Texts.ContactsView.buttonReset, for: .normal)
        resetButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .light)
        resetButton.addTarget(self, action: #selector(resetCountry), for: .touchUpInside)
    }

    private func setupSegmentedControl() {
        segmentControlGender.isHidden = true
        segmentControlGender.selectedSegmentIndex = 0
        segmentControlGender.setTitleTextAttributes([.foregroundColor: UIColor.main], for: .selected)
        segmentControlGender.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }

    private func setupTableViewContacts() {
        tableViewContacts.isHidden = true
        tableViewContacts.separatorStyle = .none
        tableViewContacts.register(ContactTableViewCell.self, forCellReuseIdentifier: ContactTableViewCell.id)
        tableViewContacts.showsHorizontalScrollIndicator = false
        tableViewContacts.showsVerticalScrollIndicator = false
        tableViewContacts.dataSource = self
        tableViewContacts.delegate = self
    }
}

// MARK: UICollectionView

extension ContactsListView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countries.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCollectionViewCell.id, for: indexPath as IndexPath) as! CountryCollectionViewCell

        cell.setup(with: countries[indexPath.row])
        
        if countries.count == 1 {
            cell.setSelectedStyle()
        }

        return cell
    }
}

extension ContactsListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.countrySelected(country: countries[indexPath.row])
    }
}

extension ContactsListView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 80)
    }
}

// MARK: UITableView

extension ContactsListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.id, for: indexPath) as? ContactTableViewCell else {
            fatalError("Could not cast ContactTableViewCell")
        }

        cell.setup(contact: contacts[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.contactSelected(contact: contacts[indexPath.row])
    }
}

extension ContactsListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

// MARK: - Delegate Contacts

protocol ContactsListViewDelegate: AnyObject {
    func countrySelected(country: Country)
    func genderSelected(gender: Gender)
    func contactSelected(contact: ContactsResponseModel)
    func refreshTableView()
}
