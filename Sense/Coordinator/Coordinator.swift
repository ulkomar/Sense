//
//  Coordinator.swift
//  Sense
//
//  Created by Uladzislau Komar on 8.03.23.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
