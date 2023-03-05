//
//  TitleAndDescriptionStackView.swift
//  Sense
//
//  Created by Uladzislau Komar on 5.03.23.
//

import UIKit

final class TitleAndDescriptionStackView: UIStackView {

    enum Label {
        case title
        case description
    }

    let title: String
    let desc: String

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = title
        label.numberOfLines = 0
        label.textColor = Colors.white
        label.font = Fonts.title1
        label.textAlignment = .center
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = desc
        label.numberOfLines = 0
        label.textColor = Colors.descriptionGray
        label.font = Fonts.description
        label.textAlignment = .center
        return label
    }()

    init(title: String, desc: String) {
        self.title = title
        self.desc = desc
        super.init(frame: .zero)
        initialization()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialization() {
        axis = .vertical
        spacing = 10
        addArrangedSubview(titleLabel)
        addArrangedSubview(descriptionLabel)
    }

    func changeColor(for lab: Label, color: UIColor) {
        switch lab {
        case .title:
            titleLabel.textColor = color
        case .description:
            descriptionLabel.textColor = color
        }
    }
}
