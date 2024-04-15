//
//  BreadCrumbIconView.swift
//  Mr Moe
//
//  Created by Omar Abdelaziz on 09/04/2024.
//

import UIKit

class BreadCrumbIconView: UIView {
    var size: CGFloat
    var number: Int {
        didSet {
            numberLabel.text = "\(number)"
        }
    }

    var withCheckMark: Bool {
        didSet {
            if withCheckMark {
                checkMark.image = UIImage(systemName: "checkmark")
                numberLabel.text = ""
                setupCheckmark()
            } else {
                checkMark.image = UIImage()
                numberLabel.text = "\(number)"
                setupNumber()
            }
        }
    }

    var color: UIColor {
        didSet {
            checkMark.tintColor = color
            circleView.layer.borderColor = color.cgColor
            numberLabel.textColor = color
        }
    }

    private let circleView = {
        let view = UIView()
        return view
    }()

    private let checkMark = UIImageView(image: UIImage(systemName: "checkmark"))

    private let numberLabel = {
        let label = UILabel()
        return label
    }()

    init(
        number: Int,
        withCheckMark: Bool = false,
        size: CGFloat = 15,
        color: UIColor = .tertiaryForeground
    ) {
        self.number = number
        self.withCheckMark = withCheckMark
        self.size = size
        self.color = color
        super.init(frame: .zero)

        setupCircle()
        if withCheckMark {
            setupCheckmark()
        } else {
            setupNumber()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCircle() {
        circleView.layer.borderColor = color.cgColor
        circleView.layer.borderWidth = size / 10
        circleView.layer.cornerRadius = size / 2

        circleView.layer.masksToBounds = true

        addSubview(circleView)

        circleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: topAnchor),
            circleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            circleView.trailingAnchor.constraint(equalTo: trailingAnchor),
            circleView.bottomAnchor.constraint(equalTo: bottomAnchor),
            circleView.widthAnchor.constraint(equalToConstant: size),
            circleView.heightAnchor.constraint(equalTo: circleView.widthAnchor),
        ])
    }

    func setupCheckmark() {
        checkMark.tintColor = color
        circleView.addSubview(checkMark)

        checkMark.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkMark.topAnchor.constraint(equalTo: circleView.topAnchor, constant: size / 10),
            checkMark.leadingAnchor.constraint(equalTo: circleView.leadingAnchor, constant: size / 10),
            checkMark.bottomAnchor.constraint(equalTo: circleView.bottomAnchor, constant: size / -10),
            checkMark.trailingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: size / -10),

        ])
    }

    func setupNumber() {
        numberLabel.font = UIFont(name: "Poppins-Regular", size: size * 2 / 3)
        numberLabel.textColor = color

        numberLabel.text = "\(number)"

        circleView.addSubview(numberLabel)

        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
        ])
    }
}

class VC: UIViewController {
    let x = BreadCrumbIconView(
        number: 1,
        withCheckMark: true,
        size: 70
    )

    override func viewDidLoad() {
        
        
        x.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(x)

        x.color = .accent
        
        x.withCheckMark = false
        
        NSLayoutConstraint.activate([
            x.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            x.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

#Preview {
    VC()
}
