//
//  SceneDelegate.swift
//  Sense
//
//  Created by Uladzislau Komar on 2.03.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = (scene as? UIWindowScene) else { return }
            window = UIWindow(windowScene: windowScene)
            window?.rootViewController = UINavigationController(
                rootViewController: LoginViewController()) 
            window?.makeKeyAndVisible()
        }
}
