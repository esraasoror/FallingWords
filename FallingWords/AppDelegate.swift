//
//  AppDelegate.swift
//  FallingWords
//
//  Created by Esraa Yasser on 9/22/19.
//  Copyright © 2019 Babbel. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        DatabaseManager().configureRealm()
        
        return true
    }
}

