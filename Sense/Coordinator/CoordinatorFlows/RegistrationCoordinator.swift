//
//  RegistrationCoordinator.swift
//  Sense
//
//  Created by Uladzislau Komar on 8.03.23.
//

import UIKit

final class RegistrationCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = [Coordinator]()

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let initialViewController = LoginViewController()
        initialViewController.coordinator = self
        navigationController.pushViewController(initialViewController, animated: true)
    }

    func showRegistrationScreen() {
        let initialViewController = RegistrationViewController()
        initialViewController.coordinator = self
        navigationController.pushViewController(initialViewController, animated: true)
    }

    func showLoginScreenAgain() {
        navigationController.popViewController(animated: true)
    }
}
