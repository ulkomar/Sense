//
//  SimpleColoredButton.swift
//  Sense
//
//  Created by Uladzislau Komar on 5.03.23.
//

import UIKit

class SimpleColoredButton: UIButton {

    init(text: String, bgColor: UIColor, textColor: UIColor) {
        super.init(frame: .zero)
        setTitle(text, for: .normal)
        tintColor = textColor
        titleLabel?.font = Fonts.getFontStyle(style: .bold, size: 20)
        backgroundColor = bgColor
        layer.cornerRadius = 15
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
