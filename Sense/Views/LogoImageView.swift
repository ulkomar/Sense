//
//  LogoImageView.swift
//  Sense
//
//  Created by Uladzislau Komar on 5.03.23.
//

import UIKit

final class LogoImageView: UIImageView {

    override init(image: UIImage? = UIImage(named: "SenseLogo")) {
        super.init(image: image)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
