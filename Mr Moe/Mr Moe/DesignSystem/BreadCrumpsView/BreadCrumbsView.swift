//
//  BreadCrumbsView.swift
//  Mr Moe
//
//  Created by Omar Abdelaziz on 08/04/2024.
//

import UIKit

final class BreadCrumbsView: UIView {
    let breadCrumbs: [BreadCrumbView.BreadCrumb]


    lazy var stackView = {
        let breadCrumbViews = breadCrumbs.map { breadCrumb in

            return BreadCrumbView(breadCrumb)
        }

        var arrangedSubviews: [UIView] = []

        for (index, breadCrumbView) in breadCrumbViews.enumerated() {
            arrangedSubviews.append(breadCrumbView)

            let isLastElement = breadCrumbViews.count - 1 == index

            lazy var forwardArrow = {
                
                
                let image = UIImageView(image: UIImage(systemName: "arrow.forward"))
            
                
                image.tintColor = .secondaryAccent

                return image
            }()

            if !isLastElement {
                arrangedSubviews.append(forwardArrow)
            }
        }

        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)

        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 10

        return stackView
    }()

    /// Description
    /// - Parameters:
    ///   - steps: steps description
    ///   - currentStepIndex: the index of the current active step starting from 0
    init(stepNames: [String], currentStepIndex: Int) {
        
        breadCrumbs = stepNames.enumerated().map { index, stepName in
            let isActive = currentStepIndex == index
            let isCompleted = index < currentStepIndex

            return BreadCrumbView.BreadCrumb(
                stepNumber: index + 1,
                name: stepName,
                isActive: isActive,
                isCompleted: isCompleted
            )
        }

        super.init(frame: .zero)

        backgroundColor = .secondaryBackground

        addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate(
            [
                stackView.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat(DesignSystem.padding.medium)),
                stackView.leadingAnchor.constraint(
                    equalTo: leadingAnchor, constant: CGFloat(DesignSystem.padding.small)
                ),
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -CGFloat(DesignSystem.padding.medium)),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CGFloat(DesignSystem.padding.small)),
            ]
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TestVC: UIViewController {
    let breadCrumbNames = ["Add Payment method", "Payment Type", "Done"]

    lazy var breadCrumbs = BreadCrumbsView(stepNames: breadCrumbNames, currentStepIndex: 0)
    override func viewDidLoad() {
        view.addSubview(breadCrumbs)

        breadCrumbs.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            breadCrumbs.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            breadCrumbs.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

#Preview {
    TestVC()
}
