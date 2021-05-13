//
//  AppDelegate.swift
//  TouchNumber
//
//  Created by 内間理亜奈 on 2017/03/02.
//  Copyright © 2017年 riana. All rights reserved.
//

import UIKit
import Firebase
import GameKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        
        // GameCenter Login
        if let presentView = window?.rootViewController {
            let target = presentView
            let player = GKLocalPlayer.localPlayer()
            player.authenticateHandler = {(viewController, error) -> Void in
                if ((viewController) != nil) {
                    print("GameCenter Login: Not Logged In > Show GameCenter Login")
                    
                    target.present(viewController!, animated: true, completion: nil);
                } else {
                    print("GameCenter Login: Log In")
                    
                    if (error == nil){
                        print("LoginAuthentication: Success")
                    } else {
                        print("LoginAuthentication: Failed")
                    }
                }
            }
        }
        
        
        // Use Firebase library to configure APIs
        FIRApp.configure()
        
        // Initialize Google Mobile Ads SDK, application IDを設定
        GADMobileAds.configure(withApplicationID: "ca-app-pub-9614012526549975~9072689644")
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

