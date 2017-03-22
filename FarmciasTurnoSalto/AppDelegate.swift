//
//  AppDelegate.swift
//  FarmciasTurnoSalto
//
//  Created by Juan Ariel on 7/3/17.
//  Copyright © 2017 Juan Ariel. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Color de statusBar
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = Utils.hexStringToUIColor(hex: "#EBEBF1");
            //statusBar.backgroundColor = Utils.hexStringToUIColor(hex: "#FFFFFF");
        }
        
        //Color texto e iconos de statusBar
        UIApplication.shared.statusBarStyle = .default
        
        return true
    }
    
//      3D-Touch
//    func handleShortcut( shortcutItem:UIApplicationShortcutItem ) -> Bool {
//        print("Handling shortcut")
//        
//        var succeeded = false
//        
//        if( shortcutItem.type == "appshortcut.share-app" ) {
//            
//            let textApp = "Próximamente Farmacia de Turno (Salto) en la App Store"
//            // set up activity view controller
//            let textToShareApp = [ textApp ]
//            let activityViewController = UIActivityViewController(activityItems: textToShareApp, applicationActivities: nil)
//            // exclude some activity types from the list (optional)
//            //activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
//            
//            // present the view controller
//            window!.rootViewController?.present(activityViewController, animated: true, completion: nil)
//            
//            succeeded = true
//            
//        }
//        
//        return succeeded
//        
//    }
//    
//    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
//        
//        print("Application performActionForShortcutItem")
//        completionHandler( handleShortcut(shortcutItem: shortcutItem) )
//        
//    }

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

