//
//  AppDelegate.swift
//  Conthem
//
//  Created by René Sandoval on 05/08/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let splash = SplashViewController()
        splash.window = window
        window?.rootViewController = splash
        window?.makeKeyAndVisible()
        return true
    }
}
