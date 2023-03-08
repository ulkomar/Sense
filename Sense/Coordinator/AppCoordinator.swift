//
//  AppCoordinator.swift
//  Sense
//
//  Created by Uladzislau Komar on 8.03.23.
//

import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let auth = true
        if auth {
            showRegistrationCootrinator()
        } else {
            // Fill this gap
        }
    }

    func showRegistrationCootrinator() {
        let registrationCoordinator = RegistrationCoordinator(navigationController: navigationController)
        childCoordinators.append(registrationCoordinator)
        registrationCoordinator.start()
    }

}
