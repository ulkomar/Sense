//
//  LoginViewController.swift
//  Sense
//
//  Created by Uladzislau Komar on 3.03.23.
//

import UIKit
import SnapKit
import Firebase

import GoogleSignIn

final class LoginViewController: UIViewController {

    @objc private lazy var googleSignInButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.addTarget(self, action: #selector(signInWithGoogle), for: .touchUpInside)
        return button
    }()

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
        let stack = UIStackView(arrangedSubviews:
                                    [nameField,
                                    passwordField])
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()

    private lazy var nameField = InputTextField(placeholderText: "Enter email or phone")
    private lazy var passwordField = InputTextField(placeholderText: "Password")
    private lazy var forgotPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Forgot password?"
        label.textColor = Colors.yellowText
        label.font = Fonts.getFontStyle(style: .regular, size: 12)
        return label
    }()

    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [loginButton, googleSignInButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        return stack
    }()

    private lazy var loginButton = SimpleColoredButton(
        text: "Log in",
        bgColor: Colors.yellowBackground,
        textColor: Colors.white)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        setupSubviews()
        setupConstraints()
    }

    private func setupSubviews() {
        view.addSubview(logo)
        view.addSubview(screenDescription)
        view.addSubview(fieldsStack)
        view.addSubview(forgotPasswordLabel)
        view.addSubview(buttonsStack)
    }

    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        logo.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(Paddings.top)
            make.centerX.equalTo(safeArea)
        }

        screenDescription.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom).offset(Paddings.top+50)
            make.leading.equalTo(safeArea).offset(Paddings.leading+30)
            make.trailing.equalTo(safeArea).offset(Paddings.trailing-30)
        }

        fieldsStack.snp.makeConstraints { make in
            make.top.equalTo(screenDescription.snp.bottom).offset(Paddings.top)
            make.leading.equalTo(view).offset(Paddings.leading)
            make.trailing.equalTo(view).offset(Paddings.trailing)
        }

        forgotPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(fieldsStack.snp.bottom).offset(10)
            make.trailing.equalTo(safeArea).offset(Paddings.trailing)
        }

        buttonsStack.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordLabel.snp.bottom).offset(Paddings.top-20)
            make.leading.equalTo(safeArea).offset(Paddings.leading)
            make.trailing.equalTo(safeArea).offset(Paddings.trailing)
        }
    }

    @objc private func login(_ action: UIButton) {

    }

    @objc private func signInWithGoogle(_ action: UIButton) {
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

            Auth.auth().signIn(with: credential) { [weak self] result, error in
                if error != nil { return }
//                self?.textLabel.text = result?.user.displayName
            }
        }
    }
}
