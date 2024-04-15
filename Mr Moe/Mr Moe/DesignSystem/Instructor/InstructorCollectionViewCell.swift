//
//  InstructorCollectionViewCell.swift
//  Mr Moe
//
//  Created by Omar Abdelaziz on 13/04/2024.
//

import UIKit

class InstructorCollectionViewCell: UICollectionViewCell {
    // MARK: - Identifier

    static let identifier = "instructorCollectionViewCell"
    var viewModel: InstructorCollectionViewItem? {
        didSet {
            guard let viewModel else { return }

            imageView.image = viewModel.instructor.image
            nameLabel.text = viewModel.instructor.name
            priceLabel.text = "\(viewModel.instructor.price)"
            subjectLabel.text = viewModel.instructor.subject
            stackViewContainer.layer.borderWidth = viewModel.isBooked ? 2 : 0
            circleView.isHidden = !viewModel.isBooked

            if let selectionOrder = viewModel.selectionOrder {
                selectionOrderLabel.text = "\(selectionOrder)"
            } else {
                selectionOrderLabel.text = ""
            }

            button.style.backgroundColor = viewModel.isBooked
                ? DesignSystem.color.accent.secondary
                : DesignSystem.color.accent.primary

            button.style.leadingIcon = viewModel.isBooked ? .bookedIcon : .bookIcon
            button.title = viewModel.isBooked ? "Booked" : "Book"
        }
    }

    var indexPath: IndexPath?
    var didPressBook: ((IndexPath) -> Void)?

    // MARK: - UI Components

    private let imageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    private let nameLabel = {
        let label = UILabel()
        label.font = DesignSystem.font.body.small
        label.textColor = DesignSystem.color.foreground.primary
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()

    private let priceLabel = {
        let label = UILabel()
        label.font = DesignSystem.font.body.xSmall
        label.textColor = DesignSystem.color.accent.secondary
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()

    private let subjectLabel = {
        let label = UILabel()
        label.font = DesignSystem.font.body.xSmall
        label.textColor = DesignSystem.color.foreground.tertiary
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()

    private let button = {
        var style = ButtonStyle(
            foregroundColor: DesignSystem.color.foreground.secondary,
            backgroundColor: DesignSystem.color.accent.primary,
            borderColor: nil,
            leadingIcon: .bookIcon,
            iconsPosition: .center
        )

        let button = MainButton(title: "Book", style: style)
        return button
    }()

    lazy var stackView = {
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            nameLabel,
            priceLabel,
            subjectLabel,
            button,
        ])

        stackView.axis = .vertical
        stackView.spacing = CGFloat(DesignSystem.spacing.xSmall)
        stackView.distribution = .equalSpacing
        stackView.alignment = .center

        return stackView
    }()

    let circleView = {
        let circleView = UIView()
        circleView.backgroundColor = DesignSystem.color.accent.secondary
        return circleView
    }()

    private let selectionOrderLabel = {
        let label = UILabel()
        label.font = DesignSystem.font.body.medium
        label.textColor = DesignSystem.color.foreground.secondary
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()

    private let stackViewContainer = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        setupCircle()
        setupStackViewContainer()
        setupStackView()
        setupImageView()
        setupButtonView()
    }

    private func setupCircle() {
        addSubview(circleView)
        circleView.addSubview(selectionOrderLabel)
        circleView.layer.zPosition = 1

        circleView.isHidden = true

        let circleViewSize: CGFloat = 32
        circleView.layer.cornerRadius = circleViewSize / 2


        circleView.translatesAutoresizingMaskIntoConstraints = false
        selectionOrderLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: topAnchor),
            circleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -DesignSystem.spacing.xSmall),
            circleView.widthAnchor.constraint(equalToConstant: circleViewSize),
            circleView.heightAnchor.constraint(equalToConstant: circleViewSize),

            selectionOrderLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            selectionOrderLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
        ])
    }

    private func setupStackViewContainer() {
        addSubview(stackViewContainer)

        stackViewContainer.layer.borderColor = DesignSystem.color.accent.secondary.cgColor
        stackViewContainer.layer.cornerRadius = DesignSystem.cornerRadius.medium

        stackViewContainer.backgroundColor = DesignSystem.color.background.secondary
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackViewContainer.topAnchor.constraint(equalTo: circleView.centerYAnchor),
            stackViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackViewContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    private func setupStackView() {
        stackViewContainer.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: stackViewContainer.topAnchor, constant: DesignSystem.padding.small),
            stackView.leadingAnchor.constraint(equalTo: stackViewContainer.leadingAnchor, constant: DesignSystem.padding.small),
            stackView.bottomAnchor.constraint(equalTo: stackViewContainer.bottomAnchor, constant: -DesignSystem.padding.small),
            stackView.trailingAnchor.constraint(equalTo: stackViewContainer.trailingAnchor, constant: -DesignSystem.padding.small),
        ])
    }

    private func setupImageView() {
        let imageViewSize = DesignSystem.size.instructorItemImageViewSize
        imageView.layer.cornerRadius = imageViewSize / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: imageViewSize),
            imageView.heightAnchor.constraint(equalToConstant: imageViewSize),
        ])
    }

    private func setupButtonView() {
        button.addTarget(self, action: #selector(didPressBookButton), for: .touchUpInside)

        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: DesignSystem.size.mainButtonSize.small.height),
            button.widthAnchor.constraint(equalToConstant: DesignSystem.size.mainButtonSize.small.width),
        ])
    }

    @objc private func didPressBookButton() {
        guard let indexPath else { return }
        didPressBook?(indexPath)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        priceLabel.text = nil
        subjectLabel.text = nil
    }
}

#Preview {
    let instructor = Instructor(
        image: UIImage.instructor1,
        name: "Mr. Omar Abdelaziz",
        price: 9000,
        subject: "Math subject"
    )
    let instructorItem = InstructorCollectionViewItem(
        instructor: instructor,
        isBooked: false,
        selectionOrder: nil
    )
    let view = InstructorCollectionViewCell(frame: CGRect(x: 0, y: 100, width: 100, height: 100))

    view.viewModel = instructorItem

    return view
}
