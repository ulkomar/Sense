//
//  RegistrationViewController.swift
//  Sense
//
//  Created by Uladzislau Komar on 8.03.23.
//

import UIKit
import SnapKit

final class RegistrationViewController: UIViewController {

    private lazy var screenDescription: TitleAndDescriptionStackView = {
        let stack = TitleAndDescriptionStackView(
            title: "Register account",
            desc: "Fill your details or continue with social media".capitalized)
        return stack
    }()

    private lazy var fieldsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameField,
                                                   emailField,
                                                   phoneField,
                                                   passwordField])
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()

    private lazy var nameField = InputTextField(placeholderText: "Name")
    private lazy var emailField = InputTextField(placeholderText: "E-mail")
    private lazy var phoneField = InputTextField(placeholderText: "Phone")
    private lazy var passwordField: InputTextField = {
        let field = InputTextField(placeholderText: "Password")
        field.enablePasswordToggle()
        return field
    }()

    private lazy var termsAndPolicyAgreement: UILabel = {
        let label = UILabel()
        label.font = Fonts.getFontStyle(style: .regular, size: 12)
        label.textColor = Colors.white
        label.text = "By signing up you agree to our Terms & Conditions and Privacy Policy"
        label.numberOfLines = 0
        return label
    }()

    private lazy var signupButton = SimpleColoredButton(
        text: "Sign un",
        bgColor: Colors.yellowBackground,
        textColor: Colors.white)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        setupSubviews()
        setupConstraints()
    }

    private lazy var orSeparator = OrSeparatorStackView()

    private lazy var socialMediaStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 35
        let iconNames = ["GoogleLogo", "FacebookLogo", "AppleLogo"]

        for (index, icon) in iconNames.enumerated() {
            let button = UIButton()
            button.tag = index
            button.addTarget(self, action: #selector(loginUsingSocialMedia), for: .touchUpInside)
            let image = UIImage(named: icon)
            button.setImage(image, for: .normal)
            stack.addArrangedSubview(button)
        }

        return stack
    }()

    private lazy var loginStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [loginLabel, loginButton])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 5
        return stack
    }()

    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.getFontStyle(style: .regular, size: 12)
        label.textColor = Colors.white
        label.text = "Already have an account?"
        return label
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        let attributes = [
            NSAttributedString.Key.foregroundColor: Colors.yellowText.withAlphaComponent(0.8),
            NSAttributedString.Key.font: Fonts.getFontStyle(style: .regular, size: 12)
        ]
        button.setAttributedTitle(
            NSMutableAttributedString(
                string: "Log in",
                attributes: attributes),
            for: .normal)
        button.addTarget(self, action: #selector(showLoginScreen), for: .touchUpInside)
        button.setTitleColor(Colors.yellowText, for: .normal)
        return button
    }()

    private func setupSubviews() {
        view.addSubview(screenDescription)
        view.addSubview(fieldsStack)
        view.addSubview(termsAndPolicyAgreement)
        view.addSubview(signupButton)
        view.addSubview(orSeparator)
        view.addSubview(socialMediaStackView)
        view.addSubview(loginStackView)
    }

    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        screenDescription.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(Paddings.top)
            make.leading.equalTo(safeArea).offset(Paddings.leading+30)
            make.trailing.equalTo(safeArea).offset(Paddings.trailing-30)
        }

        fieldsStack.snp.makeConstraints { make in
            make.top.equalTo(screenDescription.snp.bottom).offset(Paddings.top+10)
            make.leading.equalTo(view).offset(Paddings.leading)
            make.trailing.equalTo(view).offset(Paddings.trailing)
        }

        termsAndPolicyAgreement.snp.makeConstraints { make in
            make.top.equalTo(fieldsStack.snp.bottom).offset(15)
            make.leading.equalTo(safeArea).offset(Paddings.leading)
            make.trailing.equalTo(safeArea).offset(Paddings.trailing)
        }

        signupButton.snp.makeConstraints { make in
            make.top.equalTo(termsAndPolicyAgreement.snp.bottom).offset(Paddings.top-20)
            make.height.equalTo(50)
            make.leading.equalTo(safeArea).offset(Paddings.leading)
            make.trailing.equalTo(safeArea).offset(Paddings.trailing)
        }

        orSeparator.snp.makeConstraints { make in
            make.top.equalTo(signupButton.snp.bottom).offset(Paddings.top)
            make.leading.equalTo(safeArea).offset(Paddings.leading+20)
            make.trailing.equalTo(safeArea).offset(Paddings.trailing-20)
        }

        socialMediaStackView.snp.makeConstraints { make in
            make.top.equalTo(orSeparator.snp.bottom).offset(Paddings.top - 25)
            make.centerX.equalTo(safeArea)
        }

        loginStackView.snp.makeConstraints { make in
            make.top.equalTo(socialMediaStackView.snp.bottom).offset(Paddings.top - 25)
            make.centerX.equalTo(safeArea)
        }
    }

    @objc private func loginUsingSocialMedia() {

    }
    
    @objc private func showLoginScreen() {
        navigationController?.popViewController(animated: true)
    }
}
