//
//  UIColor+Hex.swift
//  Sense
//
//  Created by Uladzislau Komar on 5.03.23.
//

import Foundation
import UIKit

extension UIColor {
    public convenience init?(hex: String) {
        let rPrefix, gPrefix, bPrefix, aPrefix: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    rPrefix = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    gPrefix = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    bPrefix = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    aPrefix = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: rPrefix, green: gPrefix, blue: bPrefix, alpha: aPrefix)
                    return
                }
            }
        }

        return nil
    }
}
