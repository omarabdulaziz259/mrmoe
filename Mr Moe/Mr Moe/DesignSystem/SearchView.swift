//
//  SearchView.swift
//  Mr Moe
//
//  Created by Omar Abdelaziz on 14/04/2024.
//

import UIKit

class SearchView: UIView {
    private let leadingIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.tintColor = DesignSystem.color.search
        imageView.contentMode = .center
        return imageView
    }()

    var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search your preferred teachers"
        textField.font = DesignSystem.font.body.xSmall
        textField.borderStyle = .none
        textField.textColor = DesignSystem.color.search
        return textField
    }()

    lazy var stackView = {
        let stackView = UIStackView(arrangedSubviews: [
            leadingIconImageView,
            searchTextField,
        ])

        stackView.axis = .horizontal
        stackView.spacing = DesignSystem.spacing.large
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupView()
    }

    private func setupView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: DesignSystem.padding.xSmall),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: DesignSystem.padding.large),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -DesignSystem.padding.xSmall),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -DesignSystem.padding.large),
        ])

        // MARK: - Apply border and corner radius to the view

        layer.borderColor = DesignSystem.color.search.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}

#Preview {
    SearchView()
}
