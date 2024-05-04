//
//  ViewController.swift
//  RickAndMorty
//
//  Created by pcpos on 19/04/2024.
//

import UIKit

/// Controroller house tabs and root tabs Controroller
final class RMTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        setUpTabs()
        
        
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
        
       //icons for bars
        nav1.tabBarItem = UITabBarItem(title: "Characters",
                                       image: UIImage(systemName: "person"),
                                       tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Locations",
                                       image: UIImage(systemName: "map.circle.fill"),
                                       tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Episodes",
                                       image: UIImage(systemName: "list.and.film"),
                                       tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Setttings",
                                       image: UIImage(systemName: "gearshape"),
                                       tag: 4)
        
        
        for nav in [nav1,nav2,nav3,nav4] {
            
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers(
                   [nav1,nav2,nav3,nav4],
                   animated: true)
        
    }

 
}

