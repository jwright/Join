//
//  AppDelegate.swift
//  Join
//
//  Created by Jamie Wright on 6/3/14.
//  Copyright (c) 2014 Brilliant Fantastic. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        Parse.setApplicationId("<your Parse Application Id here", clientKey: "<your Parse Client Key here>")
        
        // Override point for customization after application launch.
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        self.window!.rootViewController = RootViewController()
        return true
    }

}

