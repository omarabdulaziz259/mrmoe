//
//  MainButton.swift
//  Mr Moe
//
//  Created by Omar Abdelaziz on 07/04/2024.
//

import UIKit

class MainButton: UIButton {
    var title: String {
        didSet {
            didSetTitle()
        }
    }

    var style: ButtonStyle {
        didSet {
            didSetStyle()
        }
    }

    static let sizes = DesignSystem.size.mainButtonSize

    private lazy var buttonHStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            leadingIconImageView,
            textLabel,
            trailingIconImageView,
        ])

        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = DesignSystem.spacing.small

        stackView.isUserInteractionEnabled = false

        return stackView
    }()

    private var leadingIconImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = DesignSystem.font.body.small
        return label
    }()

    private let trailingIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    init(title: String, style: ButtonStyle) {
        self.title = title
        self.style = style

        super.init(frame: .zero)
        didSetStyle()
        didSetTitle()

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        layer.cornerRadius = DesignSystem.cornerRadius.small
        clipsToBounds = true

        addSubview(buttonHStackView)

        if style.iconsPosition == .edge {
            NSLayoutConstraint.activate([
                buttonHStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: DesignSystem.padding.xSmall),
                buttonHStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -DesignSystem.padding.small),
            ])
        }

        buttonHStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonHStackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: DesignSystem.padding.xSmall),
            buttonHStackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -DesignSystem.padding.xSmall),

            buttonHStackView.topAnchor.constraint(equalTo: topAnchor, constant: DesignSystem.padding.large),
            buttonHStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -DesignSystem.padding.large),
            buttonHStackView.centerXAnchor.constraint(equalTo: centerXAnchor),

        ])
    }

    private func didSetTitle() {
        textLabel.text = title
    }

    private func didSetStyle() {
        leadingIconImageView.image = style.leadingIcon
        leadingIconImageView.tintColor = style.foregroundColor

        trailingIconImageView.image = style.trailingIcon
        trailingIconImageView.tintColor = style.foregroundColor

        layer.borderColor = style.borderColor?.cgColor ?? UIColor.clear.cgColor
        layer.borderWidth = style.borderColor == nil ? 0 : 1

        textLabel.textColor = style.foregroundColor

        backgroundColor = style.backgroundColor
    }
}

#Preview {
    let leadingIcon = UIImage(systemName: "minus.circle")
    let trailingIcon = UIImage(systemName: "plus.app")

    lazy var buttonStyle = ButtonStyle(foregroundColor: .black, backgroundColor: .clear, borderColor: .red, leadingIcon: leadingIcon, trailingIcon: trailingIcon, iconsPosition: .edge)

    lazy var mybutton = MainButton(title: "click me", style: buttonStyle)

    return mybutton
}
