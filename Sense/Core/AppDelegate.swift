//
//  AppDelegate.swift
//  Sense
//
//  Created by Uladzislau Komar on 2.03.23.
//

import UIKit
import Firebase
import GoogleSignIn
import FacebookLogin

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
            FirebaseApp.configure()
//            Auth.auth().addStateDidChangeListener { auth, user in
//                guard let _ = user else { return }
//
//            }
            ApplicationDelegate.shared.application(
                    application,
                    didFinishLaunchingWithOptions: launchOptions
                )
            UINavigationBar.appearance().tintColor = Colors.barButtons
            return true
        }

    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
//            ApplicationDelegate.shared.application(
//                app,
//                open: url,
//                sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
//                annotation: options[UIApplication.OpenURLOptionsKey.annotation]
//            )
            return GIDSignIn.sharedInstance.handle(url)
        }
}
