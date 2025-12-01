//
//  RMTabBarController.swift
//  RickAndMorty
//
//  Created by Abdallah Adel
//

import UIKit

/// Controller that houses the tabs and root tab controllers
final class RMTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
        applyLiquidGlassAppearance()
    }

    private func setUpTabs() {
        let charactersVC = RMCharacterViewController()
        let locationsVC = RMLocationViewController()
        let episodesVC = RMEpisodeViewController()
        let settingsVC = RMSettingsViewController()

        charactersVC.navigationItem.largeTitleDisplayMode = .automatic
        locationsVC.navigationItem.largeTitleDisplayMode = .automatic
        episodesVC.navigationItem.largeTitleDisplayMode = .automatic
        settingsVC.navigationItem.largeTitleDisplayMode = .automatic

        let nav1 = UINavigationController(rootViewController: charactersVC)
        let nav2 = UINavigationController(rootViewController: locationsVC)
        let nav3 = UINavigationController(rootViewController: episodesVC)
        let nav4 = UINavigationController(rootViewController: settingsVC)

        // Modern SF Symbols with filled variants
        nav1.tabBarItem = UITabBarItem(
            title: "Characters",
            image: UIImage(systemName: "person.2"),
            selectedImage: UIImage(systemName: "person.2.fill")
        )
        nav2.tabBarItem = UITabBarItem(
            title: "Locations",
            image: UIImage(systemName: "globe.americas"),
            selectedImage: UIImage(systemName: "globe.americas.fill")
        )
        nav3.tabBarItem = UITabBarItem(
            title: "Episodes",
            image: UIImage(systemName: "play.rectangle.on.rectangle"),
            selectedImage: UIImage(systemName: "play.rectangle.on.rectangle.fill")
        )
        nav4.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape"),
            selectedImage: UIImage(systemName: "gearshape.fill")
        )

        for nav in [nav1, nav2, nav3, nav4] {
            nav.navigationBar.prefersLargeTitles = true
            nav.navigationBar.applyLiquidGlassStyle()
        }

        setViewControllers(
            [nav1, nav2, nav3, nav4],
            animated: true
        )
    }
    
    private func applyLiquidGlassAppearance() {
        // Apply liquid glass to tab bar
        tabBar.applyLiquidGlassStyle()
        
        // Set global tint
        view.tintColor = LiquidGlassTheme.portalGreen
    }
}
