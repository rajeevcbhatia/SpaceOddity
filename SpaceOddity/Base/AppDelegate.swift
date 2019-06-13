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
        let launchesViewController = LaunchesViewController(service: ProcessInfo.processInfo.currentService)
        let navController = UINavigationController(rootViewController: launchesViewController)
        
        window?.rootViewController = navController
    }

}

private extension ProcessInfo {
    
    var currentService: LaunchesServiceable {
        if arguments.contains("testHappyFlow") {
            return MockLaunchesService()
        } else if arguments.contains("testErrorFlow") {
            return MockLaunchesService(responseString: MockLaunches.failureResponseString)
        } else {
            return LaunchesNetworkService()
        }
    }
    
}
