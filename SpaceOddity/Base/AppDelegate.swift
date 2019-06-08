//
//  AppDelegate.swift
//  SpaceOddity
//
//  Created by Rajeev Bhatia on 07/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        showLaunchesScreen()
        
        return true
    }
    
    private func showLaunchesScreen() {
        let launchesService = LaunchesNetworkService()
        let launchesViewController = LaunchesViewController(service: launchesService)
        let navController = UINavigationController(rootViewController: launchesViewController)
        
        window?.rootViewController = navController
    }

}

