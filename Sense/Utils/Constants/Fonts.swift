//
//  Fonts.swift
//  Sense
//
//  Created by Uladzislau Komar on 5.03.23.
//

import UIKit

enum FontStyle: String {
    case black
    case blackItalic
    case bold
    case bolditalic
    case extraBold
    case extraBoldItalic
    case extraLight
    case extraLightItalic
    case italic
    case light
    case lightItalic
    case medium
    case mediumItalic
    case regular
    case semiBold
    case semiBoldItalic
    case thin
    case thinItalic
}

struct Fonts {
    private static let fontName = "Poppins"

    static let title1 = getFontStyle(style: .bold, size: 30)
    static let description = getFontStyle(style: .medium, size: 16)

    static func getFontStyle(style: FontStyle, size: CGFloat) -> UIFont {
        guard let font = UIFont(
            name: fontName + "-" + (style.rawValue).capitalized,
            size: size) else {
            return UIFont.systemFont(ofSize: 10)
        }
        return font
    }
}
