//
//  SceneDelegate.swift
//  RickAndMorty
//
//  Created by Abdallah Adel
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Ensuring the scene is correctly cast as a UIWindowScene.
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Creating an instance of RMTabBarController as the root view controller.
        let tabBarController = RMTabBarController()
        
        // Initializing the window with the given windowScene.
        let window = UIWindow(windowScene: windowScene)
        
        // Setting the root view controller to the tabBarController.
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()  // Display the window.
        
        // Assign the window to the SceneDelegate's window property.
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Optional: Handle cleanup when the scene is released by the system.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Optional: Restart tasks that were paused when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Optional: Handle tasks when the scene is transitioning to an inactive state.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Optional: Undo changes made when the scene entered the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Optional: Save data and release shared resources when the scene enters the background.
    }
}

