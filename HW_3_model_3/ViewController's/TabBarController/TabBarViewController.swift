//
//  TabBarViewController.swift
//  DZ_2_modul3
//
//  Created by Nikita Shipovskiy on 30/05/2024.
//

import UIKit

final class TabBarViewController: UITabBarController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
        
    }
    
    
    private func setupTabBar() {
        let mainVc = MainViewController()
        mainVc.tabBarItem.title = "Главная"
        mainVc.tabBarItem.image = UIImage(systemName: "house")
        mainVc.tabBarItem.selectedImage = UIImage(systemName: "house.fill")

        
        let profileVc = ProfileViewController()
        profileVc.tabBarItem.title = "Профиль"
        profileVc.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        profileVc.tabBarItem.selectedImage = UIImage(systemName: "person.crop.circle.fill")
        
        tabBar.tintColor = UIColor(named: "mainColor")
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.barTintColor = .black
        
        let navMainVc = UINavigationController(rootViewController: mainVc)
        let navProfileVc = UINavigationController(rootViewController: profileVc)
        
        setViewControllers([navMainVc, navProfileVc], animated: true)
        
    }
    


}

