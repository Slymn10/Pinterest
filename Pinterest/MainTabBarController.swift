//
//  MainTabBarController.swift
//  Pinterest
//
//  Created by Süleyman Koçak on 30.05.2020.
//  Copyright © 2020 Suleyman Kocak. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .mainGray
        tabBar.barTintColor = .systemBackground
        tabBar.clipsToBounds = true
        setupViewControllers()
    }

    func setupViewControllers(){
        let feedVC = UINavigationController(rootViewController: FeedViewController())
        feedVC.tabBarItem.image = UIImage(named: "logo-unselected-tab")
        feedVC.tabBarItem.title = "Home"
        feedVC.tabBarItem.selectedImage = UIImage(named:"logo-tab")?.withRenderingMode(.alwaysOriginal)
        feedVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.mainGray], for: .selected)
        viewControllers = [
            feedVC,
            generateNavController(title: "Notifications", image: "notifications-tab"),
            generateNavController(title: "Saved", image: "profile-tab")

        ]
    }

    func generateNavController(title:String,image:String)->UINavigationController{
        let vc = UIViewController()
        vc.view.backgroundColor = .white

        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: String(image))
        navController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.mainGray], for: .selected)
        return navController
    }

}
