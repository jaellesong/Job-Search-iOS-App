//
//  MainTabBarController.swift
//  ECA2
//
//  Created by Jaelle Song on 13/9/20.
//  Copyright © 2020 Jaelle Song. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // mainly force the results and save view controllers to load
        // so the notification listeners for job data updates can be initialized
        for viewController in self.viewControllers ?? [] {
            if let navigationVC = viewController as? UINavigationController, let rootVC = navigationVC.viewControllers.first {
                let _ = rootVC.view
            } else {
                let _ = viewController.view
            }
        }
    }

}
