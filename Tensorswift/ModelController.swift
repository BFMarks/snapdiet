//
//  ModelController.swift
//  CookieCrunch
//
//  Created by Bryan Marks on 2/24/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import Foundation
import UIKit
//import FacebookCore
//import FBSDKCoreKit
import FBSDKLoginKit
import SwiftyJSON
import Alamofire
import AppsFlyerLib
import AdSupport
//import FacebookLogin

class ModelController: UIViewController {
    var dict : [String : AnyObject]!
    var idfa = ""
    
    
    ///////////DELETE AFTER ONBOARDING
    @IBAction func TESTONBOARDING(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "onboard") as! OnboardingController
        let mongoIDRetreived = UserDefaults.standard.string(forKey: "mongoID")
        print("***mongoIDRetreived****\(mongoIDRetreived)")
        if (mongoIDRetreived == nil){
            noLogin()
        } else {
            self.present(vc, animated: false, completion: nil)
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//         let mongoIDRetreived = UserDefaults.standard.string(forKey: "mongoID")
        
        self.idfa = IDFA.shared.identifier!
        print("***self.idfa****\(self.idfa)")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func backToCam(_ sender: Any) {
         self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func noLogin() {
        let alertController = UIAlertController(title: "Could Not Login!", message: "I'm sorry, we could not login because of either internet or your login", preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
        let DestructiveAction = UIAlertAction(title: "We're Sorry", style: UIAlertActionStyle.destructive) {
            (result : UIAlertAction) -> Void in
            print("Destructive")
        }
        
        // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            print("OK")
        }
        
        alertController.addAction(DestructiveAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func alreadyLoggedIn() {
        let alertController = UIAlertController(title: "You're Already Logged In", message: "You are already logged in :)", preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
        let DestructiveAction = UIAlertAction(title: "Cool", style: UIAlertActionStyle.destructive) {
            (result : UIAlertAction) -> Void in
            print("Destructive")
        }
        
        // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            print("OK")
             self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(DestructiveAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func btnFBLoginPressed(_ sender: AnyObject) {
        
        
        let mongoIDRetreived = UserDefaults.standard.string(forKey: "mongoID")
        print("***mongoIDRetreived****\(mongoIDRetreived)")
        
        //        let propertyToCheck = (sender as AnyObject).currentTitle!
        if (mongoIDRetreived == nil){
           
            //            performSegue(withIdentifier: "tracker", sender: nil)
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.getFBUserData()
                        fbLoginManager.logOut()
                    }
                    //// add else here for error handling
                } else {
                    self.noLogin()
                    }
                }
            }
        } else {
            alreadyLoggedIn()
           

        }
    }
    
    
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]

                    print(self.dict)
                    
                    let email = (result as? [String : AnyObject])?["email"]
                    let first_name = (result as? [String : AnyObject])?["first_name"]
                    let id = (result as? [String : AnyObject])?["id"]
                    let facebookId = Int(id as! String)!
                    let last_name = (result as? [String : AnyObject])?["last_name"]
                    
                    
                    
                    if let identifier = IDFA.shared.identifier {
                        // use the identifier
                        self.idfa = identifier
                    } else {
                        // put any fallback logic in here
                        self.idfa = "LAT"
                    }
                    
                    let parameters: [String: Any] = [
                        "facebookId" : facebookId,
                        "first_name" : first_name!,
                        "email" : email!,
                        "last_name": last_name!,
                        "idfa": self.idfa,
//                        "List": [
//                            [
//                                "IdQuestion" : 5,
//                                "IdProposition": 2,
//                                "Time" : 32
//                            ],
//                            [
//                                "IdQuestion" : 4,
//                                "IdProposition": 3,
//                                "Time" : 9
//                            ]
//                        ]
                    ]
                    
                    Alamofire.request("https://snapdiet.herokuapp.com/userTest?facebookId=\(facebookId)", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                        .responseJSON { response in
                            print("1Getting Back Value to see if user exists\(response)")
                            
//                            to get status code
                            if let status = response.response?.statusCode {
                                switch(status){
                                case 201:
                                    print("example success")
                                    print("First Post")
                                default:
                                    print("error with response status: \(status)")
                                    
                                    
                                }
                            }
                            //to get JSON return value
                            if let result = response.result.value {
                                print("Getting Back Value to see if user exists")

                                let JSON = result as! NSDictionary
                                print(JSON)
                                print("JSON VALUE WERE CHECKING AGAINST \(JSON)")
                                
                                
                                let found = JSON["response"] as? [AnyObject]
                                print("found is \(found)")
                                for item in found! {
                                    let mongoID = item["id"]! as? String
                                    print("String is \(mongoID!)")
                                    UserDefaults.standard.set(mongoID, forKey: "mongoID")
                                    
                                    
                                    
                                }
                            
                            
                        }
                            let mongoIDRetreived = UserDefaults.standard.string(forKey: "mongoID")
                            print("***mongoIDRetreived****\(mongoIDRetreived)")
                            self.alreadyLoggedIn()
                            return
                    }

//                    makeNewUser(){
                    Alamofire.request("https://snapdiet.herokuapp.com/user", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                        .responseJSON { response in
                            print(response)
                            
                            //to get status code
                            if let status = response.response?.statusCode {
                                switch(status){
                                case 201:
                                    print("example success")
                                default:
                                    print("error with response status: \(status)")
                                    print("error USER MAY EXIST")
                                    
                                }
                            }
                            //to get JSON return value
                            if let result = response.result.value {
                                let JSON = result as! NSDictionary
//                                print(JSON)
                                let myStringDict = JSON as? [String:AnyObject]
//                                print("********\(myStringDict)")
//                                let mongoID = myStringDict?["id"]
                                
                                //optional dictionary type
                                if let mongoID = myStringDict?["id"] as? String {
                                    // no error
                                    
                                     UserDefaults.standard.set(mongoID, forKey: "mongoID")
                                    self.sendToOnboarding()
                                }

                            }
                        
                    }
                }
            })
            
        }
    }
    
    func sendToOnboarding() {
        let launchedBefore = UserDefaults.standard.bool(forKey: "onBoardedBefore")
        if launchedBefore  {
            print("Not first launch.")
        } else {
            print("First launch, setting UserDefault.")
            UserDefaults.standard.set(true, forKey: "onBoardedBefore")
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "onboard") as! OnboardingController
            
            self.present(vc, animated: false, completion: nil)
        }
    }
    
}
