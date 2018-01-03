//
//  InfoViewController.swift
//  Tensorswift
//
//  Created by Bryan Marks on 4/18/17.
//  Copyright © 2017 Bryan Frederick Marks. All rights reserved.
//

//
//  MainViewController.swift
//  Tensorswift
//
//  Created by Bryan Marks on 3/26/17.
//  Copyright © 2017 Bryan Frederick Marks. All rights reserved.
//

import UIKit
import WebKit

class InfoViewController: UIViewController
{
    
    @IBOutlet weak var foodsNow: UITextView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cam(_ sender: Any) {
          self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    

    
}

