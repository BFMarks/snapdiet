//
//  OnboardingController2.swift
//  Tensorswift
//
//  Created by Bryan Marks on 4/9/17.
//  Copyright © 2017 Bryan Frederick Marks. All rights reserved.
//


import Foundation
import UIKit
//import FacebookCore
//import FBSDKCoreKit
//import FBSDKLoginKit
import SwiftyJSON
import Alamofire
import AppsFlyerLib
//import FacebookLogin

class OnboardingController2: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func toHome(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
}
