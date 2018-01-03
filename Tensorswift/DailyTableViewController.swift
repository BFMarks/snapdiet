//
//  DailyTableViewController.swift
//  Tensorswift
//
//  Created by Bryan Marks on 5/1/17.
//  Copyright © 2017 Bryan Frederick Marks. All rights reserved.
//

import UIKit
import Foundation
import AVKit
import AVFoundation
//import SwiftDate


class DailyTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
//    var newString = ""
//    @IBOutlet var topView: UIView!
//    
//    var newHeader:[String] = [""]
//    @IBOutlet var tableView: UITableView!
//    
//    
    
    @IBOutlet weak var dayReadOut: UILabel!

    @IBOutlet var dailyTopView: UIView!
    
    @IBAction func backToCamera(_ sender: Any) {
          self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }

//    @IBOutlet weak var dailyCalories: UILabel!
//    
//    var foodDict:NSDictionary = [:]
//    
//    var  foodArray = [Any]()
//    var dateNameArray:[String] = []
//    
//    var  nameArray:[String] = []
//    var  fiberArray = [Int]()
//    var  calorieArray = [Int]()
//    var  saturatedFatsArray = [Int]()
//    var  totalFatsArray = [Int]()
//    var  sodiumArray = [Int]()
//    var sugarArray = [Int]()
//    var  cholesterolArray = [Int]()
//    var  carbsArray = [Int]()
//    var  proteinArray = [Int]()
//    var createdAtArray = [Any]()
//    var newDateArray:[String] = []
//    
//    var dailyCalorieNumber: Int = 0
    
    
    var parsedCalArray = [Int]()
    var  foodArray4 = [[Int]]()
    var nameArraysOfArrays = [[String]]()
    
    
    var rowClick = 0
    
    @IBOutlet weak var dailyView: UIView!
    @IBOutlet weak var dailyTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dailyTableView.delegate = self
        self.dailyTableView.dataSource = self
        
        /////Adding Delay To get Newest Food
        //        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        //        DispatchQueue.main.asyncAfter(deadline: when) {
        //            // Your code with delay
        //            self.getJSONFromServer()
        //        }
//        self.getJSONFromServer()
        
        self.getDate()
        

        self.dayReadOut.text = "Calories : \(String(describing: self.parsedCalArray[self.rowClick]))"
        
        
    }
    
    func getDate() {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        print("date: \(date)")
        print("calendar: \(calendar)")
        print("hour: \(hour)")
        print("minutes: \(minutes)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
//        print(self.foodArray4.count)
        return self.foodArray4[self.rowClick].count
    }
    
    
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableViewAutomaticDimension
    //    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return self.newHeader[0]
//    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let title = UILabel()
        title.font = UIFont(name: "Avenir", size: 19)!
        title.textColor = UIColor.black
        
        //        let header = view as! UITableViewHeaderFooterView
        //        header.textLabel?.font=title.font
        //        header.textLabel?.textColor=title.textColor
        //        header.textLabel?.textAlignment = NSTextAlignmentCenter
    }
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DailyTableViewCell

//        let numberOfRow = calArrayOfArrays[self.rowClick]
//        print("foodArray4[self.rowClick]\(foodArray4)")
//        print("foodArray4[self.rowClick]\(foodArray4[self.rowClick])")
//        print("foodArray4[self.rowClick]\(foodArray4[self.rowClick][indexPath.row])")
        
        
        let newCalArrayForDaily = self.foodArray4[self.rowClick][indexPath.row]
        let newNameArrayForDaily = self.nameArraysOfArrays[self.rowClick][indexPath.row]
        cell.dailyFoodCalsText.text = String(describing: newCalArrayForDaily)
        cell.dailyNameFoodText.text = newNameArrayForDaily
        
//        if self.parsedCalArray[indexPath.row] >= 2200 {
//            cell.title.textColor = UIColor.red
//        } else if (self.parsedCalArray[indexPath.row] < 2200) && (self.parsedCalArray[indexPath.row] > 1500) {
//            cell.title.textColor = UIColor.green
//        } else if (self.parsedCalArray[indexPath.row] < 800) {
//            cell.title.textColor = UIColor.gray
//        }
//        cell.title.text = String(self.parsedCalArray[indexPath.row])
//        cell.foodName.text = dateNameArray[indexPath.row]
//        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        print("Button tapped")
        
        print("You selected cell #\(indexPath.row)!")
        //        let indexPath = tableView.indexPathForSelectedRow!
        //        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        
        //        passedCalArray = currentCell.textLabel?.text
        //        performSegue(withIdentifier: "toDailyView", sender: self)
        
    }
    
//    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
//        
//        if (segue.identifier == "toDailyView") {
//            // initialize new view controller and cast it as your view controller
//            let viewController = segue.destination as! DailyTableViewController
//            // your new view controller should have property that will store passed value
//            viewController.passedCalArray = self.newCalArray
//        }
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    
    func convertDateFormatter(date: String) -> String
    {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"//this your string date format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let date = dateFormatter.date(from: date)
        
        
        dateFormatter.dateFormat = "MMM dd yyyy"///this is you want to convert format  EEEE HH:mm =Monday 18:09
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let timeStamp = dateFormatter.string(from: date!)
        
//        self.todaysDate = timeStamp
        
        return timeStamp
    }
    
//    var todaysDate = ""
//    
//    var testDate = ""
//    
//    var dictFood = [String: [Int]]()
//    var newITEMDICT = [String: AnyObject]()
//    
//    var newFoodObject = [AnyObject]()
//    var newCalArray = [Int]()
//    
//    
//    var parsedCalArray = [Int]()
//    
//    
//    var newTestArray:[String] = []
//    
//    
//    
//    var sortedArray2 = [(key: String, value: [Int])]()
    
    
//    func getJSONFromServer() {
//        //        self.newHeader[0] = "Welcome Juli"
//        
//        
//        //////UNCOMMENT TO GET BACK LOGIN USER
//        let mongoIDRetreived = UserDefaults.standard.string(forKey: "mongoID")
//        //        print("***mongoIDRetreived****\(mongoIDRetreived)")
//        
//        //                let mongoIDTEST = "58ebc95060d9850400254123"
//        let api = API()
//        let variableString: String = mongoIDRetreived!
//        api.getOrders(section: variableString) { responseObject, error in
//            print("responseObject = \(responseObject); error = \(error)")
//            if let response = responseObject {
//                print("JSON is \(response)")
//                let found = response["food"] as? [AnyObject]
//                print("found is \(found)")
//                for item in found! {
//                    //                    let string = item["type"] as! String
//                    let cals = (item["calories"] as! NSString).doubleValue
//                    
//                    let createdAtValue = item["createdAt"]
//                    
//                    //Creating String date
//                    let testDate = self.convertDateFormatter(date: createdAtValue as! String)
//                    
//                    if self.dateNameArray == [] {
//                        //                            self.newCalArray.removeAll()
//                        print("NIL DATE")
//                    } else if testDate != self.dateNameArray[0]{
//                        self.newCalArray.removeAll()
//                    }
//                    print("testDatearrat*: \(self.dateNameArray)")
//                    print("testDate*: \(testDate)")
//                    
//                    self.newCalArray.append(Int(cals))
//                    
//                    self.foodArray.append(self.calorieArray as [Int])
//                    self.dictFood[testDate] = self.newCalArray
//                    
//                    
//                    
//                    
//                    let sortedArray = self.dictFood.sorted(by: {$1.0 < $0.0})
//                    
//                    
//                    self.sortedArray2 = sortedArray
//                    
//                    
//                    
//                    let keys = sortedArray.map {return $0.0 }
//                    
//                    
//                    
//                    
//                    print("keysssssss*: \(keys.count)")
//                    print("self.dateNameArrayPRIOR*: \(self.dateNameArray.count)")
//                    
//                    
//                    self.dateNameArray = keys
//                    print("dateNameArray*: \(self.dateNameArray.count)")
//                    let values = sortedArray.map {return $0.1 }
//                    self.calArrayOfArrays = values
//                    print("newCalArray*: \(self.newCalArray)")
//                    
//                    
//                }
//                
//                
//            }  else if error != nil {
//                
//                self.dateNameArray.append(contentsOf: ["*Make sure to allow access in settings!*" ])
//                
//            }
//            
//            
//            for (_, value) in self.sortedArray2 {
//                print("*****valueTHISISDICTVALUE\(value)")
//                let _value = value as? [Int]
//                let newValue = _value?.reduce(0,+)
//                print("*****newValue\(newValue)")
//                self.parsedCalArray.append(newValue!)
//                
//            }
//            
//            print("*****parsedCalArray#####\(self.parsedCalArray)")
//            
//            
//            print("timeStamp\(self.todaysDate)")
//            ////Top View Count
//            if self.todaysDate != self.dateNameArray[0] {
//                self.dailyCalorieNumber = 0
//            } else {
//                self.dailyCalorieNumber = self.parsedCalArray[0]
//            }
//            self.dailyCalories.text = "Calories Today: \(String(self.dailyCalorieNumber))"
//            
//            
//            self.tableView.reloadData()
//            
//            
//        }
//        
//    }
    
//    var  calArrayOfArrays = [[Int]]()
//    var foodArray1:[AnyObject] = []
//    var foodArrayObject2:[AnyObject] = []
//    
//    
    
    /////RATING
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let more = UITableViewRowAction(style: .normal, title: "No Affect") { action, index in
            
            
            
            
        }
        more.backgroundColor = UIColor.lightGray
        
        
        let favorite = UITableViewRowAction(style: .normal, title: "Hurts") { action, index in
            print("favorite button tapped")
            
            
            
        }
        favorite.backgroundColor = UIColor.red
        
        let share = UITableViewRowAction(style: .normal, title: "Helpful") { action, index in
            print("share button tapped")
            
            
            
        }
        share.backgroundColor = hexStringToUIColor(hex: "#5EBACE")
        
        return [share, favorite, more]
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    @IBAction func backToTableView(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tableView") as! TableViewController
        

        self.present(vc, animated: false, completion: nil)
    }
    

    
}
