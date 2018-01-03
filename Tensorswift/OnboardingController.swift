//
//  OnboardingController.swift
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

class OnboardingController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    
    @IBOutlet weak var weightDropDown: UIPickerView!
    @IBOutlet weak var weightDropDownText: UITextField!
    
    var list = ["4Ft-11inches", "5Ft-0inches", "5Ft-2inches","5Ft-3inches","5Ft-4inches","5Ft-5in","5Ft-6in","5Ft-7in","5Ft-8in","5Ft-9in","5Ft-10in","5Ft-11in","6F","6Ft-1in","6Ft-2in","6Ft-3in","6Ft-4in","6Ft-5in","6Ft-6in","6Ft-7in","6Ft-8in", "6Ft-9in"]
    var weightList = ["115","120","125","130","135","140","145","150","155","160","165","175", "180", "185","190","195","200","205","210","215","220","225","230","235"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addDoneButtonOnKeyboard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        
        return list.count
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if pickerView == dropDown {
            //Height Drop down
            self.view.endEditing(true)
            return list[row]
            
        } else if pickerView == weightDropDown{
           
            self.view.endEditing(true)
            return weightList[row]

            
        }

        
        self.view.endEditing(true)
        return list[row]
        
    }
    
    var chosenHeigth = ""
    var chosenWeight = ""
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == dropDown {
            //Height Drop down
            self.textBox.text = self.list[row]
            print("  self.textBox.text*** : \(self.textBox.text)")
            self.dropDown.isHidden = true
            let chosenHeight1 =  self.textBox.text
            chosenHeigth = chosenHeight1!
            print("chosenHeigth*** : \(chosenHeigth)")
            UserDefaults.standard.set(chosenHeigth, forKey: "chosenHeigth")
            let theirChosenHeigth = UserDefaults.standard.string(forKey: "chosenHeigth")
            print("theirChosenHeigth*** : \(theirChosenHeigth)")

        } else if pickerView == weightDropDown{
            //pickerView2
            //Weight dropDown
            self.weightDropDownText.text = self.weightList[row]
            print("self.weightDropDownText.text*** : \(self.weightDropDownText.text)")
            self.weightDropDown.isHidden = true
            let chosenWeight1 =  self.weightDropDownText.text
//            self.weightDropDownText.isUserInteractionEnabled = false
            if ((Int(chosenWeight1!)! <
                350) && (Int(chosenWeight1!)! > 95)){
            
                
            chosenWeight = chosenWeight1!
            print("chosenWeight*** : \(chosenWeight)")
            print("chosenWeight11111*** : \(chosenWeight1)")
            UserDefaults.standard.set(chosenWeight, forKey: "chosenWeight")
            let theirChosenWeight = UserDefaults.standard.string(forKey: "chosenWeight")
            print("theirChosenHeigth*** : \(theirChosenWeight)")
            
            } else {
                weightIsNotRight()
            }
        }
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(OnboardingController.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.weightDropDownText.inputAccessoryView = doneToolbar
    }
    
    func doneButtonAction() {
        let newWeight = self.weightDropDownText.text
        UserDefaults.standard.set(newWeight, forKey: "chosenWeight")
        print("newWeight*** : \(newWeight)")
        self.chosenWeight = newWeight!
        self.weightDropDownText.resignFirstResponder()
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.textBox {
            self.dropDown.isHidden = false
            //if you dont want the users to se the keyboard type:
            
            textField.endEditing(false)
        }
        
    }
    
    var postHeight = ""
    var postWeight = 0
    
    func post(postHeight: String, postWeight:Int){
        let mongoIDRetreived = UserDefaults.standard.string(forKey: "mongoID")!
        
        let newMongoString = String(describing: mongoIDRetreived)

        
        print("***newMongoString****\(newMongoString)")
        let parameters: [String: Any] = [
            "height" : self.postHeight,
            "weight" : self.postWeight,
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

    
    func weightIsNotRight() {
        let alertController = UIAlertController(title: "Can you please enter a more realistic weight?", message: "Can you please enter a weight between 95lbs and 350lbs?  (Unless you are a garden gnome or a sumo wrestler in which case email support", preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
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
    

    
    @IBAction func board1(_ sender: Any) {
       
        if (chosenHeigth == "" || chosenWeight == "") {
            didNotEnterValues()
        } else if (Int(self.chosenWeight)! > 388 && Int(self.chosenWeight)! < 80) {
            weightIsNotRight()
        } else {
            
            
            let mongoIDRetreived = UserDefaults.standard.string(forKey: "mongoID")
            print("***mongoIDRetreived****\(mongoIDRetreived)")
            
            //        let propertyToCheck = (sender as AnyObject).currentTitle!
            if (mongoIDRetreived == nil){
                
                
            } else {
              
                
//              ///////POST HEIGHT WEIGHT
//                let parameters: [String: Any] = [
//                    "height" : chosenHeigth,
//                    "weight" : chosenWeight,
//                 
//                ]
//                
//                
//                
//                Alamofire.request("https://snapdiet.herokuapp.com/user/\(mongoIDRetreived)", method: .post, parameters: parameters, encoding: JSONEncoding.default)
//                    .responseJSON { response in
//                        print(response)
//                        
//                        //to get status code
//                        if let status = response.response?.statusCode {
//                            switch(status){
//                            case 201:
//                                print("example success")
//                            default:
//                                print("error with response status: \(status)")
//                                print("error USER MAY EXIST")
//                                
//                            }
//                        }
//                        //to get JSON return value
//                        if let result = response.result.value {
//                            let JSON = result as! NSDictionary
//                            print(JSON)
//                            
//                        }
//                }
//                
            }

            
            
            performSegue(withIdentifier: "toOnBoard1", sender: sender)
        }
    }}
