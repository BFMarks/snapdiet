//
//  OnboardingController1.swift
//  Tensorswift
//
//  Created by Bryan Marks on 4/9/17.
//  Copyright © 2017 Bryan Frederick Marks. All rights reserved.
//



import Foundation
import UIKit
//import FacebookCore
//import FBSDKCoreKit
import FBSDKLoginKit
import SwiftyJSON
import Alamofire
import AppsFlyerLib
//import FacebookLogin

class OnboardingController1: UIViewController {
    
    var _goalString = ""
    var idfa = ""
    
    @IBAction func loseWeight(_ sender: Any) {
        
        self._goalString = "Lose Weight"
        post(_goalString: self._goalString)
         UserDefaults.standard.set(self._goalString, forKey: "savedGoals")
        performSegue(withIdentifier: "toOnBoard2", sender: sender)

    }
    
    @IBAction func mainWeight(_ sender: Any) {
            self._goalString = "Maintain Weight"
        post(_goalString: self._goalString)
        UserDefaults.standard.set(self._goalString, forKey: "savedGoals")
           performSegue(withIdentifier: "toOnBoard2", sender: sender)
    }
    @IBAction func gainWeight(_ sender: Any) {
            self._goalString = "Gain Weight"
        post(_goalString: self._goalString)
        UserDefaults.standard.set(self._goalString, forKey: "savedGoals")
           performSegue(withIdentifier: "toOnBoard2", sender: sender)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func post(_goalString: String){
        let mongoIDRetreived = UserDefaults.standard.string(forKey: "mongoID")!
        
        let newMongoString = String(describing: mongoIDRetreived)
        
        
        if let identifier = IDFA.shared.identifier {
            // use the identifier
            self.idfa = identifier
        } else {
            // put any fallback logic in here
            self.idfa = "LAT"
        }
        
        
        print("***newMongoString****\(newMongoString)")
        let parameters: [String: Any] = [
            "goals" : _goalString,
            "idfa" : self.idfa,
                ]
        Alamofire.request("https://snapdiet.herokuapp.com/user/\(newMongoString)", method: .post, parameters: parameters, encoding: JSONEncoding.default)
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
                    print(JSON)
                    
                }
        }
    }
    
    func didNotEnterValues() {
        let alertController = UIAlertController(title: "No Data?", message: "If we have those values we can start to track your health!  If we track your health, you'll start to look really sexy!  If you start to look really sexy, then you'll probbaly meet someone who is really attracted to you but you'll be like 'naaaa, I did this for me and my health, this ain't about you.'", preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
        let DestructiveAction = UIAlertAction(title: "Uh What?", style: UIAlertActionStyle.destructive) {
            (result : UIAlertAction) -> Void in
            print("Destructive")
        }
        
        // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
        let okAction = UIAlertAction(title: "Good Point", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            print("OK")
        }
        
        alertController.addAction(DestructiveAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

  
  }
