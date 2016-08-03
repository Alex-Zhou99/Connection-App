//
//  AppDelegate.swift
//  exmaple
//
//  Created by Edward on 7/13/16.
//  Copyright © 2016 Edward. All rights reserved.
//

import UIKit
import Firebase
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        FIRApp.configure()
        login()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }

    func login(){
        if FIRAuth.auth()?.currentUser != nil{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let naviVC = storyboard.instantiateViewControllerWithIdentifier("RoomVC") as!
            UINavigationController
            window?.rootViewController = naviVC
        }
    }
}

