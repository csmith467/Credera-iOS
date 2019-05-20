//
//  MainTabBarAppViewController.swift
//  Credera-iOS
//
//  Created by Zachary Slayter on 1/2/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarAppViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var viewControllerArray: [UIViewController] = []
        
        // Initialize the Tab Bar controllers via their respective storyboards
        // The TabBarItems with titles & icons are in each Storyboard's first scene
        
        if let firstVC: UIViewController = UIStoryboard(name: "VerseList", bundle: Bundle.main).instantiateInitialViewController() {
            viewControllerArray.append(firstVC)
        }
        if let secondVC: UIViewController = UIStoryboard(name: "Book", bundle: Bundle.main).instantiateInitialViewController() {
            viewControllerArray.append(secondVC)
        }
        self.setViewControllers(viewControllerArray, animated: false)
        
        // Default to the Home Tab
        self.setSelectedTab(Constants.TabBarScreens.first)
        
        // Set tab bar styling
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.tintColor = UIColor(red: 13, green: 71, blue: 161)
        self.tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.tabBar.layer.shadowRadius = 5
        self.tabBar.layer.shadowOpacity = 0.8
        self.tabBar.layer.masksToBounds = false
    }
    
    func setSelectedTab(_ tabBarScreen: Constants.TabBarScreens) {
        self.selectedIndex = tabBarScreen.rawValue
    }

}
