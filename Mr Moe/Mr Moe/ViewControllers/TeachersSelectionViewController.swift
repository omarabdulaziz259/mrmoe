//
//  TeachersSelectionViewController.swift
//  Mr Moe
//
//  Created by Omar Abdelaziz on 07/04/2024.
//

import UIKit

class TeachersSelectionViewController: UIViewController {
    // MARK: - Variables

    private var collectionViewItems: [InstructorCollectionViewItem] = []
    private var numberOfSelectedInstructors = 0

    // MARK: - Ui Components

    private let Header = MainHeader(fullTitle: "Very good..", boldText: "Very good..", subTitle: "Please choose your preferred teachers.")

    private let searchView = SearchView(frame: .zero)

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.register(InstructorCollectionViewCell.self, forCellWithReuseIdentifier: InstructorCollectionViewCell.identifier)

        return collectionView
    }()

    private let backButton = {
        let buttonStyle = ButtonStyle(
            foregroundColor: DesignSystem.color.foreground.primary,
            backgroundColor: DesignSystem.color.background.tertiary,
            iconsPosition: .center
        )

        let button = MainButton(title: "Back", style: buttonStyle)

        return button
    }()

    private let confirmButton = {
        let buttonStyle = ButtonStyle(
            foregroundColor: DesignSystem.color.foreground.secondary,
            backgroundColor: DesignSystem.color.accent.primary,
            iconsPosition: .center
        )
        let button = MainButton(title: "Confirm", style: buttonStyle)
        return button
    }()

    private lazy var buttonsStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            backButton,
            confirmButton,
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = DesignSystem.spacing.small
        return stackView
    }()

    private lazy var stackView = {
        let stackView = UIStackView(arrangedSubviews: [
            Header,
            searchView,
            collectionView,
            buttonsStackView,
        ])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = DesignSystem.spacing.large
        return stackView
    }()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        collectionView.delegate = self
        collectionView.dataSource = self

        for index in 1 ... 30 {
            let instructor = Instructor(
                image: UIImage(named: "instructor\(index % 6 + 1)")!,
                name: "Mr. Mohamed Ali",
                price: 4500,
                subject: "math Teacher"
            )
            collectionViewItems.append(
                InstructorCollectionViewItem(
                    instructor: instructor,
                    isBooked: false
                )
            )
        }
        setupSubViews()
    }

    func setupSubViews() {
        view.backgroundColor = DesignSystem.color.background.primary

        setupStackView()
//        setupHeader()
//        setupSearchView()
//        setupCollectionView()
//        setupButtonsStackView()
    }

    func setupStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }

    func setupHeader() {
        view.addSubview(Header)
        Header.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            Header.topAnchor.constraint(equalTo: view.topAnchor),
            Header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            Header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            Header.heightAnchor.constraint(equalToConstant: 16.0 / 100.0 * view.frame.height),
        ])
    }

    func setupSearchView() {
        view.addSubview(searchView)
        searchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: Header.bottomAnchor, constant: DesignSystem.spacing.xLarge),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: DesignSystem.padding.xLarge),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -DesignSystem.padding.xLarge),
        ])
    }

    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: DesignSystem.spacing.xLarge),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: DesignSystem.padding.xxLarge),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -75),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -DesignSystem.padding.xxLarge),
        ])
    }

    func setupButtonsStackView() {
        view.addSubview(buttonsStackView)
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: DesignSystem.spacing.xLarge),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: DesignSystem.padding.xxLarge),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -DesignSystem.padding.xxLarge),
        ])
    }

    func didPressBook(at indexPath: IndexPath) {
        guard !collectionViewItems[indexPath.row].isBooked else { return }
        collectionViewItems[indexPath.row].isBooked = true
        numberOfSelectedInstructors += 1
        collectionViewItems[indexPath.row].selectionOrder = numberOfSelectedInstructors
        collectionView.reloadData()
    }
}

extension TeachersSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionViewItems.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.0 - DesignSystem.spacing.medium, height: 220)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InstructorCollectionViewCell.identifier, for: indexPath) as? InstructorCollectionViewCell else {
            fatalError("Failed to dequeue (InstructorCollectionViewCell) in ViewController ")
        }

        cell.viewModel = collectionViewItems[indexPath.row]
        cell.didPressBook = didPressBook
        cell.indexPath = indexPath

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return DesignSystem.spacing.medium
    }
}

#Preview {
    TeachersSelectionViewController()
}
