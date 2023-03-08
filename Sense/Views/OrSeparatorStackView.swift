//
//  OrSeparatorStackView.swift
//  Sense
//
//  Created by Uladzislau Komar on 6.03.23.
//

import UIKit

final class OrSeparatorStackView: UIStackView {

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

        leftView.snp.makeConstraints { make in
            make.leading.equalTo(self)
            make.trailing.equalTo(wordORView.snp.leading).offset(-15)
            make.centerY.equalTo(self)
            make.height.equalTo(1)
        }

        rightView.snp.makeConstraints { make in
            make.leading.equalTo(wordORView.snp.trailing).offset(15)
            make.trailing.equalTo(self)
            make.centerY.equalTo(self)
            make.height.equalTo(1)
        }

        wordORView.snp.makeConstraints { make in
            make.leading.equalTo(leftView.snp.trailing).offset(15)
            make.trailing.equalTo(rightView.snp.leading).offset(-15)
            make.centerY.equalTo(self)
        }
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
