//
//  LoginController.swift
//  Tensorswift
//
//  Created by Bryan Marks on 4/5/17.
//  Copyright © 2017 Morten Just Petersen. All rights reserved.
//

import Foundation


class LoginController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
       
    }
    
    @IBAction func backToView(_ sender: Any) {
         self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    

    
}

    
    

