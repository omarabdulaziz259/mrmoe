//
//  ButtonStyle.swift
//  Mr Moe
//
//  Created by Omar Abdelaziz on 08/04/2024.
//

import UIKit

struct ButtonStyle {
    var foregroundColor: UIColor
    var backgroundColor: UIColor
    var borderColor: UIColor?
    var leadingIcon: UIImage?
    var trailingIcon: UIImage?
    let iconsPosition: IconPosition
}

extension ButtonStyle {
    enum IconPosition {
        case edge
        case center
    }
}

