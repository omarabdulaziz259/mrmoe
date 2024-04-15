//
//  BreadCrumbView.swift
//  Mr Moe
//
//  Created by Omar Abdelaziz on 09/04/2024.
//

import UIKit

extension BreadCrumbsView {
    class BreadCrumbView: UIView {
        struct BreadCrumb {
            let stepNumber: Int
            let name: String
            let isActive: Bool
            let isCompleted: Bool
        }

        var color: UIColor {
            didSet {
                iconView.color = color
                textLabel.textColor = color
            }
        }

        let breadCrumb: BreadCrumb

        lazy var HStackView = {
            let stackView = UIStackView(arrangedSubviews: [self.iconView, self.textLabel])
            stackView.axis = .horizontal
            stackView.distribution = .fillProportionally
            stackView.alignment = .center
            stackView.spacing = 4
            return stackView
        }()

        lazy var iconView: BreadCrumbIconView = {
            let iconView = BreadCrumbIconView(number: breadCrumb.stepNumber, withCheckMark: breadCrumb.isCompleted)

            return iconView
        }()

        let textLabel = {
            let label = UILabel()
            label.font = DesignSystem.font.body.xxSmall
            return label
        }()

        init(_ breadCrumb: BreadCrumb) {
            self.breadCrumb = breadCrumb
            color = breadCrumb.isActive || breadCrumb.isCompleted
                ? .secondaryAccent
                : .tertiaryForeground

            super.init(frame: .zero)

            iconView.color = color
            textLabel.textColor = color

            textLabel.text = breadCrumb.name

            addSubview(HStackView)

            HStackView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                HStackView.topAnchor.constraint(equalTo: topAnchor),
                HStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                HStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
                HStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                HStackView.centerXAnchor.constraint(equalTo: centerXAnchor),

            ])
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

class ViewC: UIViewController {
    let testBreadCrumb = BreadCrumbsView.BreadCrumbView.BreadCrumb(stepNumber: 1, name: "omar", isActive: false, isCompleted: false)

    override func viewDidLoad() {
        let myBreadCrumbView = BreadCrumbsView.BreadCrumbView(testBreadCrumb)

        view.addSubview(myBreadCrumbView)
        myBreadCrumbView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myBreadCrumbView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myBreadCrumbView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

#Preview {
    ViewC()
}
