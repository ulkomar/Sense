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

class LoginViewController: UIViewController {

    @objc private lazy var googleSignInButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.addTarget(self, action: #selector(signInWithGoogle), for: .touchUpInside)
        return button
    }()

    private lazy var fieldsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews:
                                    [nameField,
                                     loginField,
                                     passwordField,
                                     buttonsStack])
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()

    private lazy var nameField: UITextField = {
        let field = UITextField()
        field.layer.borderColor = UIColor.black.cgColor
        field.layer.borderWidth = 1
        field.placeholder = "Name"
        return field
    }()

    private lazy var loginField: UITextField = {
        let field = UITextField()
        field.layer.borderColor = UIColor.black.cgColor
        field.layer.borderWidth = 1
        field.placeholder = "Login"
        return field
    }()

    private lazy var passwordField: UITextField = {
        let field = UITextField()
        field.layer.borderColor = UIColor.black.cgColor
        field.layer.borderWidth = 1
        field.placeholder = "Password"
        return field
    }()

    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [loginButton, registrationButton, googleSignInButton])
        stack.axis = .horizontal
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
        view.backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }

    private func setupSubviews() {
        view.addSubview(fieldsStack)
    }

    private func setupConstraints() {
        fieldsStack.snp.makeConstraints { make in
            make.top.equalTo(view).offset(300)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
        }
    }

    @objc private func login(_ action: UIButton) {

    }

    @objc private func signInWithGoogle(_ action: UIButton) {

    }
}
