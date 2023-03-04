//
//  AppDelegate.swift
//  Sense
//
//  Created by Uladzislau Komar on 2.03.23.
//

import UIKit
import Firebase

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
            return true
        }
}
