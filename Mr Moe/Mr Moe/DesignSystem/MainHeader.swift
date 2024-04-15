//
//  MainHeader.swift
//  Mr Moe
//
//  Created by Omar Abdelaziz on 07/04/2024.
//

import UIKit

class MainHeader: UIView {
    private let title: UILabel = {
        let label = UILabel()
        label.font = DesignSystem.font.header.medium
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    private let subTitle: UILabel = {
        let label = UILabel()
        label.font = DesignSystem.font.header.small
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    private lazy var stackView = {
        let stackView = UIStackView(arrangedSubviews: [title, subTitle])
        stackView.axis = .vertical
        stackView.spacing = DesignSystem.spacing.xxSmall
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()
    init(fullTitle: String, boldText: String? = "", subTitle: String) {
        self.subTitle.text = subTitle
        super.init(frame: .zero)

        title.text = fullTitle

        guard let boldText else {
            setupView()
            return
        }

        let attributedString = NSMutableAttributedString(string: fullTitle)

        let boldRange = (attributedString.string as NSString).range(of: boldText)

        attributedString.addAttribute(
            .font,
            value: DesignSystem.font.header.large ?? UIFont.boldSystemFont(ofSize: 24),
            range: boldRange
        )

        title.attributedText = attributedString

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        backgroundColor = .accent
        roundCorners(
            [
                .layerMaxXMaxYCorner,
                .layerMinXMaxYCorner,
            ],
            withRadius: DesignSystem.cornerRadius.header
        )

        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -DesignSystem.padding.xxLarge),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: DesignSystem.padding.xxSmall),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: DesignSystem.padding.xxSmall ),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -DesignSystem.padding.xxSmall ),
        ])
//
    }
}

extension UIView {
    /// Round each corner separately
    func roundCorners(_ corners: [CACornerMask], withRadius radius: CGFloat) {
        layer.cornerRadius = radius

        var caCornerMasks: CACornerMask = []

        for corner in corners {
            caCornerMasks.insert(corner)
        }

        layer.maskedCorners = caCornerMasks
    }
}

#Preview {
    MainHeader(fullTitle: "Welcome Mohamed Ragab", boldText: "Mohamed Ragab", subTitle: "Please choose your subjects")
}
