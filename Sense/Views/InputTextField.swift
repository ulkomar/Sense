//
//  InputTextField.swift
//  Sense
//
//  Created by Uladzislau Komar on 5.03.23.
//

import UIKit

final class InputTextField: UITextField {

    private let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 20)

    private let attributes = [
        NSAttributedString.Key.foregroundColor: Colors.descriptionGray,
        NSAttributedString.Key.font: Fonts.getFontStyle(style: .regular, size: 12)
    ]

    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    init(placeholderText: String) {
        super.init(frame: .zero)
        attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: attributes)
        initialization()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialization() {
        layer.borderColor = Colors.descriptionGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        textColor = Colors.white
        font = Fonts.getFontStyle(style: .regular, size: 12)
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
