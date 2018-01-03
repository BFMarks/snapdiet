//
//  AppDelegate.swift
//  Tensorswift
//
//  Created by Bryan Frederick Marks on 1/9/17.
//  Copyright © 2017 Bryan Frederick Marks. All rights reserved.

//USE THIS TUTORIAL TO BUILD LOGIN
//////https://scotch.io/tutorials/build-a-sailsjs-app-from-api-to-authentication

import UIKit
import FacebookLogin
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate:  UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
         let mongoIDRetreived = UserDefaults.standard.string(forKey: "mongoID")
        print("***mongoIDRetreived****\(mongoIDRetreived)")
        
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
 

//func onConversionDataReceived(_ installData: [AnyHashable: Any]) {
//    let status: String? = (installData["af_status"] as? String)
//    if (status == "Non-organic") {
//        let sourceID: String? = (installData["media_source"] as? String)
//        let campaign: String? = (installData["campaign"] as? String)
//        print("This is a none organic install. Media source: \(sourceID)  Campaign: \(campaign)")
//    }
//    else if (status == "Organic") {
//        print("This is an organic install.")
//    }
//}

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//        let tableCon = TableViewController()
//        tableCon.getJSONFromServer()
//        print("tableCon.getJSONFromServer()")
//        TableViewController().getJSONFromServer()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

