//
//  DesignSystem.swift
//  Mr Moe
//
//  Created by Omar Abdelaziz on 09/04/2024.
//

import UIKit

struct DesignSystem {
    static let color = ColorsContainer()
    static let font = FontsContainer()
    static let spacing = SpacingsContainer()
    static let padding = PaddingsContainer()
    static let size = SizesContainer()
    static let cornerRadius = CornersRadius()
}

struct ColorsContainer {
    let accent = (
        primary: UIColor.accent,
        secondary: UIColor.secondaryAccent
    )
    let background = (
        primary: UIColor.primaryBackground,
        secondary: UIColor.secondaryBackground,
        tertiary: UIColor.tertiaryBackground
    )

    let foreground = (
        primary: UIColor.primaryForeground,
        secondary: UIColor.secondaryForeground,
        tertiary: UIColor.tertiaryForeground
    )
    let search = UIColor.search
}

struct FontsContainer {
    private static let poppinsRegular = "Poppins-Regular"
    private static let poppinsSemiBold = "Poppins-SemiBold"
    private static let poppinsBold = "Poppins-Bold"
    private static let poppinsExtraBold = "Poppins-ExtraBold"

    let header = (
        /// small: UIFont(name: poppinsRegular, size: 20),
        small: UIFont(name: poppinsRegular, size: 16),
        /// medium: UIFont(name: poppinsSemiBold, size: 32),
        medium: UIFont(name: poppinsSemiBold, size: 20),
        /// large: UIFont(name: poppinsExtraBold, size: 32)
        large: UIFont(name: poppinsExtraBold, size: 20)
    )
    let body = (
       /// xxSmall: UIFont(name: poppinsRegular, size: 10),
        xxSmall: UIFont(name: poppinsRegular, size: 6),
       /// xSmall: UIFont(name: poppinsRegular, size: 12),
        xSmall: UIFont(name: poppinsRegular, size: 8),
       /// small: UIFont(name: poppinsRegular, size: 16),
        small: UIFont(name: poppinsRegular, size: 12),
       /// medium: UIFont(name: poppinsSemiBold, size: 16),
        medium: UIFont(name: poppinsSemiBold, size: 12),
       /// large: UIFont(name: poppinsSemiBold, size: 18),
        large: UIFont(name: poppinsSemiBold, size: 14),
       /// xLarge: UIFont(name: poppinsSemiBold, size: 20)
        xLarge: UIFont(name: poppinsSemiBold, size: 16)
    )
}

struct SpacingsContainer {
    /// xxSmall is  4
    let xxSmall = 2.0
    /// xSmall is 8
    let xSmall = 4.0
    /// small is 8
    let small = 8.0
    /// medium is 12
    let medium = 10.0
    /// large is 16
    let large = 12.0
    /// xLarge is 20
    let xLarge = 16.0
}

struct PaddingsContainer {
    /// xxSmall is  4
    let xxSmall = 2.0
    /// xSmall is  8
    let xSmall = 4.0
    /// small is 10
    let small = 8.0
    /// medium is 12
    let medium = 10.0
    /// large is 16
    let large = 12.0
    /// xLarge is 20
    let xLarge = 16.0
    /// xxLarge is 32
    let xxLarge = 22.0
}

struct SizesContainer {
    let mainButtonSize = (
        /// small is CGSize(width: 140, height: 36),
        small: CGSize(width: 140, height: 40),
        /// medium is CGSize(width: 180, height: 56),
        medium: CGSize(width: 180, height: 56),
        /// large is CGSize(width: 360, height: 60)
        large: CGSize(width: 360, height: 60)
    )
    
    let instructorItemImageViewSize = 50.0
}

struct CornersRadius {
    /// small is 8
    let small: CGFloat = 8
    /// medium is 12
    let medium: CGFloat = 12
    /// header is 50
    let header: CGFloat = 50
}

struct TeachersSelectionPageHeights {
    
}
