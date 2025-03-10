//
//  AppDelegate.swift
//  RickAndMorty
//
//  Created by pcpos on 19/04/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // Initialize UIWindow and set up RMTabBarController as the root view controller
        if #available(iOS 13.0, *) {
            // No need for UIWindow initialization here if using SceneDelegate for iOS 13+.
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
            let tabBarController = RMTabBarController() // Your root view controller
            window?.rootViewController = tabBarController
            window?.makeKeyAndVisible()
        }

        return true
    }

    // MARK: UISceneSession Lifecycle (only needed for iOS 13+)

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // Use this method to release any resources that were specific to the discarded scenes.
    }

    // MARK: - Handling Background and Foreground Lifecycle

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Handle tasks when the app enters the background
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Handle tasks when the app re-enters the foreground
    }
}


