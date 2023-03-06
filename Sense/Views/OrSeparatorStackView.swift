//
//  OrSeparatorStackView.swift
//  Sense
//
//  Created by Uladzislau Komar on 6.03.23.
//

import UIKit

class OrSeparatorStackView: UIStackView {

    private lazy var leftView = GradientView(
        gradientStartColor: UIColor(hex: "#F79515"),
        gradientEndColor: UIColor(hex: "#FFC52A"))
    private lazy var rightView = GradientView(
        gradientStartColor: UIColor(hex: "#FFC52A"),
        gradientEndColor: UIColor(hex: "#F79515"))
    private lazy var wordORView: UILabel = {
        let label = UILabel()
        label.text = "or"
        label.textColor = Colors.white
        label.font = Fonts.getFontStyle(style: .medium, size: 20)
        return label
    }()

    init() {
        super.init(frame: .zero)
        initialization()
        setupConstraints()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initialization() {
        addArrangedSubview(leftView)
        addArrangedSubview(wordORView)
        addArrangedSubview(rightView)
        axis = .horizontal
        distribution = .equalCentering
        alignment = .center
    }

    private func setupConstraints() {

        leftView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            leftView.trailingAnchor.constraint(equalTo: wordORView.leadingAnchor, constant: -15),
            leftView.heightAnchor.constraint(equalToConstant: 1),
            leftView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0)
        ])

        rightView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightView.leadingAnchor.constraint(equalTo: wordORView.trailingAnchor, constant: 15),
            rightView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            rightView.heightAnchor.constraint(equalToConstant: 1),
            rightView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0)
        ])

        wordORView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wordORView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: 15),
            wordORView.trailingAnchor.constraint(equalTo: rightView.leadingAnchor, constant: -15),
            wordORView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0)
        ])
    }

}

// MARK: - Gradient View

final class GradientView: UIView {

    private let gradient: CAGradientLayer = CAGradientLayer()
    private let gradientStartColor: UIColor
    private let gradientEndColor: UIColor

    init(gradientStartColor: UIColor, gradientEndColor: UIColor) {
        self.gradientStartColor = gradientStartColor
        self.gradientEndColor = gradientEndColor
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradient.frame = self.bounds
    }

    override func draw(_ rect: CGRect) {
        gradient.frame = self.bounds
        gradient.colors = [gradientEndColor.cgColor, gradientStartColor.cgColor]
        gradient.startPoint = CGPoint(x: 1, y: 1)
        gradient.endPoint = CGPoint(x: 0.3, y: 1)
        if gradient.superlayer == nil {
            layer.insertSublayer(gradient, at: 0)
        }
    }
}
