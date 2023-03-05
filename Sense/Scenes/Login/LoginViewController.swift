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

    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [loginButton, registrationButton, googleSignInButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        return stack
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.tintColor = .black
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()

    private lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.tintColor = .black
        button.backgroundColor = .systemBlue
        return button
    }()

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
    }

    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        logo.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(50)
            make.centerX.equalTo(safeArea)
        }

        screenDescription.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom).offset(100)
            make.leading.equalTo(safeArea).offset(50)
            make.trailing.equalTo(safeArea).offset(-50)
        }

        fieldsStack.snp.makeConstraints { make in
            make.top.equalTo(screenDescription.snp.bottom).offset(50)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
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
