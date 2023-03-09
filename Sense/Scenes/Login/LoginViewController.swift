//
//  LoginViewController.swift
//  Sense
//
//  Created by Uladzislau Komar on 3.03.23.
//

import UIKit
import SnapKit
import Firebase
import FacebookLogin

import GoogleSignIn

final class LoginViewController: UIViewController {

    // MARK: Variables

    weak var coordinator: RegistrationCoordinator?

    // MARK: UIViews

    private lazy var logo = LogoImageView()

    private lazy var screenDescription: TitleAndDescriptionStackView = {
        let stack = TitleAndDescriptionStackView(
            title: "Welcome back",
            desc: "Login to your account")
        stack.changeColor(
            for: .description,
            color: Colors.white)
        return stack
    }()

    private lazy var fieldsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameField,
                                                   passwordField])
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()

    private lazy var nameField = InputTextField(placeholderText: "Enter email or phone")
    private lazy var passwordField: InputTextField = {
        let field = InputTextField(placeholderText: "Password")
        field.enablePasswordToggle()
        return field
    }()

    private lazy var forgotPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Forgot password?"
        label.textColor = Colors.yellowText
        label.font = Fonts.getFontStyle(style: .regular, size: 12)
        return label
    }()

    private lazy var loginButton = SimpleColoredButton(
        text: "Log in",
        bgColor: Colors.yellowBackground,
        textColor: Colors.white)

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
            button.addTarget(self, action: #selector(registerUsingSocialMedia), for: .touchUpInside)
            let image = UIImage(named: icon)
            button.setImage(image, for: .normal)
            stack.addArrangedSubview(button)
        }

        return stack
    }()

    private lazy var createAccountStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [createAccountLabel, createAccountButton])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 5
        return stack
    }()

    private lazy var createAccountLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.getFontStyle(style: .regular, size: 12)
        label.textColor = Colors.white
        label.text = "Don't have an account?"
        return label
    }()

    private lazy var createAccountButton: UIButton = {
        let button = UIButton()
        let attributes = [
            NSAttributedString.Key.foregroundColor: Colors.yellowText.withAlphaComponent(0.8),
            NSAttributedString.Key.font: Fonts.getFontStyle(style: .regular, size: 12)
        ]
        button.setAttributedTitle(
            NSMutableAttributedString(
                string: "Create account",
                attributes: attributes),
            for: .normal)
        button.addTarget(self, action: #selector(showRegistrationScreen), for: .touchUpInside)
        button.setTitleColor(Colors.yellowText, for: .normal)
        return button
    }()

    // MARK: Lify cycle functions

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        setupSubviews()
        setupConstraints()
    }

    // MARK: Setup functions

    private func setupSubviews() {
        view.addSubview(logo)
        view.addSubview(screenDescription)
        view.addSubview(fieldsStack)
        view.addSubview(forgotPasswordLabel)
        view.addSubview(loginButton)
        view.addSubview(orSeparator)
        view.addSubview(socialMediaStackView)

        view.addSubview(createAccountStackView)
    }

    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        logo.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(Paddings.top+15)
            make.centerX.equalTo(safeArea)
        }

        screenDescription.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom).offset(Paddings.top+25)
            make.leading.equalTo(safeArea).offset(Paddings.leading+30)
            make.trailing.equalTo(safeArea).offset(Paddings.trailing-30)
        }

        fieldsStack.snp.makeConstraints { make in
            make.top.equalTo(screenDescription.snp.bottom).offset(Paddings.top+10)
            make.leading.equalTo(view).offset(Paddings.leading)
            make.trailing.equalTo(view).offset(Paddings.trailing)
        }

        forgotPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(fieldsStack.snp.bottom).offset(10)
            make.trailing.equalTo(safeArea).offset(Paddings.trailing)
        }

        loginButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordLabel.snp.bottom).offset(Paddings.top-20)
            make.height.equalTo(50)
            make.leading.equalTo(safeArea).offset(Paddings.leading)
            make.trailing.equalTo(safeArea).offset(Paddings.trailing)
        }

        orSeparator.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(Paddings.top)
            make.leading.equalTo(safeArea).offset(Paddings.leading+20)
            make.trailing.equalTo(safeArea).offset(Paddings.trailing-20)
        }

        socialMediaStackView.snp.makeConstraints { make in
            make.top.equalTo(orSeparator.snp.bottom).offset(Paddings.top - 25)
            make.centerX.equalTo(safeArea)
        }

        createAccountStackView.snp.makeConstraints { make in
            make.top.equalTo(socialMediaStackView.snp.bottom).offset(Paddings.top - 25)
            make.centerX.equalTo(safeArea)
        }
    }

    // MARK: Class functions

    @objc private func login(_ action: UIButton) {

    }

    @objc private func showRegistrationScreen() {
        coordinator?.showRegistrationScreen()
    }


    @objc private func registerUsingSocialMedia(_ action: UIButton) {
        switch action.tag {
        case 0:
            signInWithGoogle()
        case 1:
            signInWithFacebook()
        case 2:
            break
        default:
            break
        }
    }

    private func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!

        GIDSignIn.sharedInstance.signIn(withPresenting: self) { result, error in
            if error != nil { return }

            guard let IDToken = result?.user.idToken,
                  let accessToken = result?.user.accessToken else { return }

            let credential = GoogleAuthProvider.credential(
                withIDToken: IDToken.tokenString,
                accessToken: accessToken.tokenString)

            Auth.auth().signIn(with: credential) { _, error in
                if error != nil { return }
//                self?.textLabel.text = result?.user.displayName
            }
        }
    }

    private func signInWithFacebook() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile"], from: self) { result, error in
            if let error = error {
                print("Encountered Erorr: \(error)")
            } else if let result = result, result.isCancelled {
                print("Cancelled")
            } else {
                print("Logged In")
            }
        }
    }
}
