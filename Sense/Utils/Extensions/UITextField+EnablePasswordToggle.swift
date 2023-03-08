//
//  UITextField+EnablePasswordToggle.swift
//  Sense
//
//  Created by Uladzislau Komar on 7.03.23.
//

import UIKit
import SnapKit

extension UITextField {
    func enablePasswordToggle() {
        let button = UIButton()
        let openEyeImage = UIImage(systemName: "eye")?
            .withTintColor(Colors.descriptionGray, renderingMode: .alwaysOriginal)
        let hiddenEyeImage = UIImage(systemName: "eye.slash")?
            .withTintColor(Colors.descriptionGray, renderingMode: .alwaysOriginal)

        switch isSecureTextEntry {
        case true:
            button.setImage(hiddenEyeImage, for: .normal)
            button.setImage(openEyeImage, for: .selected)
        case false:
            button.setImage(openEyeImage, for: .normal)
            button.setImage(hiddenEyeImage, for: .selected)
        }

        button.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)

        let rightFrame = UIView()
        rightFrame.frame = CGRect(x: 0, y: 0, width: 40, height: 40)

        button.frame = CGRect(x: 0, y: 0, width: rightFrame.frame.width, height: rightFrame.frame.width)
        button.contentHorizontalAlignment = .leading
        rightFrame.addSubview(button)

        rightView = rightFrame
        rightViewMode = .always
    }

    @objc private func togglePasswordView() {
        isSecureTextEntry.toggle()
        enablePasswordToggle()
    }
}
