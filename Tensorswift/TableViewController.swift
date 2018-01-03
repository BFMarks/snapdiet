
////
////  TableViewController.swift
////  RecoveryAI
////
////  Created by Bryan Marks on 2/11/17.
////  Copyright © 2017 Bryan Marks. All rights reserved.
////
/////http://stackoverflow.com/questions/30054854/sort-a-dictionary-in-swift
//////SORT OBJECT BY DATE FIELD
/////https://gist.github.com/pocketkk/db5895d64a212a6e9ea1
import UIKit
import Foundation
import AVKit
import AVFoundation
//import SwiftDate


class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var newString = ""
    @IBOutlet var topView: UIView!
    
    var newHeader:[String] = [""]
    @IBOutlet var tableView: UITableView!

    @IBAction func backToCam(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var dailyCalories: UILabel!
    
    var foodDict:NSDictionary = [:]
    
    var  foodArray = [Any]()
    var dateNameArray:[String] = []
    
    var  nameArray:[String] = []
    var  fiberArray = [Int]()
    var  calorieArray = [Int]()
    var  saturatedFatsArray = [Int]()
    var  totalFatsArray = [Int]()
    var  sodiumArray = [Int]()
    var sugarArray = [Int]()
    var  cholesterolArray = [Int]()
    var  carbsArray = [Int]()
    var  proteinArray = [Int]()
    var createdAtArray = [Any]()
    var newDateArray:[String] = []
    
    var dailyCalorieNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        /////Adding Delay To get Newest Food
//        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
//        DispatchQueue.main.asyncAfter(deadline: when) {
//            // Your code with delay
//            self.getJSONFromServer()
//        }
        self.getJSONFromServer()
        
        self.getDate()
        
        
        
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
        
        return self.dateNameArray.count
    }
    
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.newHeader[0]
    }
    
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
  

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
//        cell.textLabel?.text="row#\(indexPath.row)"
//        cell.detailTextLabel?.text="subtitle#\(indexPath.row)"
//        
//        
//        cell.textLabel?.numberOfLines = 0
//        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
//        cell.textLabel?.font = UIFont(name:"Avenir", size:17)
//        
//        
//        
//        cell.textLabel?.text = dateNameArray[indexPath.row]
////
//        cell.layer.borderColor = UIColor.lightGray.cgColor
//        cell.layer.borderWidth = 0.1
//        cell.layer.cornerRadius = 10
        
        ////WHAT NEEDS TO BE THERE
        
        
        
        if self.parsedCalArray[indexPath.row] >= 2200 {
            cell.title.textColor = UIColor.red
        } else if (self.parsedCalArray[indexPath.row] < 2200) && (self.parsedCalArray[indexPath.row] > 1500) {
            cell.title.textColor = UIColor.green
        } else if (self.parsedCalArray[indexPath.row] < 800) {
            cell.title.textColor = UIColor.gray
        }
        cell.title.text = String(self.parsedCalArray[indexPath.row])
        cell.foodName.text = dateNameArray[indexPath.row]

        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        print("Button tapped")
      
        print("You selected cell #\(indexPath.row)!")
        let rowClicked = indexPath.row
//        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        
//        passedCalArray = currentCell.textLabel?.text
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "toDailyView") as! DailyTableViewController
        
        vc.parsedCalArray =  self.parsedCalArray
        vc.nameArraysOfArrays = self.nameArraysOfArrays
        vc.foodArray4 = self.foodArray4
        vc.rowClick = rowClicked
        self.present(vc, animated: false, completion: nil)

    }
    
//    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
//        
//        if (segue.identifier == "toDailyView") {
//            // initialize new view controller and cast it as your view controller
//            let viewController = segue.destination as! DailyTableViewController
////             your new view controller should have property that will store passed value
//            viewController.foodArray4 = self.foodArray4
//        }
//    }
//    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    func convertDateFormatter(date: String) -> String
    {
        var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"//this your string date format
        dateFormatter.timeZone = NSTimeZone(name: localTimeZoneAbbreviation) as TimeZone!
        let date = dateFormatter.date(from: date)
        
        
        dateFormatter.dateFormat = "MMM dd yyyy"///this is you want to convert format  EEEE HH:mm =Monday 18:09
        dateFormatter.timeZone = NSTimeZone(name: localTimeZoneAbbreviation) as TimeZone!
        let timeStamp = dateFormatter.string(from: date!)
        
//        self.todaysDate = timeStamp
        
        return timeStamp
    }
    

    
    var todaysDate = ""

    var testDate = ""
    
    
    ////////My Date
    var dictFood = [String: [Int]]()
    var dictName = [String: [String]]()
    var newITEMDICT = [String: AnyObject]()
    
    var newFoodObject = [AnyObject]()
    
    ////My Arrays
    var newCalArray = [Int]()
    var newFoodNameArray = [String]()
    
    
    var parsedCalArray = [Int]()
    
    
    var newTestArray:[String] = []
    
    
    
    var sortedArray2 = [(key: String, value: [Int])]()
    
    
    func getJSONFromServer() {
        //        self.newHeader[0] = "Welcome Juli"
        
        
        //////UNCOMMENT TO GET BACK LOGIN USER
        let mongoIDRetreived = UserDefaults.standard.string(forKey: "mongoID")
        //        print("***mongoIDRetreived****\(mongoIDRetreived)")
        
        if (mongoIDRetreived == nil){
                        print("First launch, setting UserDefault.")
            //            UserDefaults.standard.set(true, forKey: "launchedBefore")
            //            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as! ModelController
            //
            //            self.present(vc, animated: false, completion: nil)
                        return
                    }
        
//                let mongoIDTEST = "58ebc95060d9850400254123"
        let api = API()
        let variableString: String = mongoIDRetreived!
        api.getOrders(section: variableString) { responseObject, error in
            print("responseObject = \(String(describing: responseObject)); error = \(String(describing: error))")
            if let response = responseObject {
                print("JSON is \(response)")
                let found = response["food"] as? [AnyObject]
                print("found is \(String(describing: found))")
                for item in found! {
                    //                    let string = item["type"] as! String
                    let cals = (item["calories"] as! NSString).doubleValue
                    let foodName = (item["type"] as! String)
                    let createdAtValue = item["createdAt"]
                    
                    //Creating String date
                    let testDate = self.convertDateFormatter(date: createdAtValue as! String)
                    
                            if self.dateNameArray == [] {
//                            self.newCalArray.removeAll()
                                print("NIL DATE")
                            } else if testDate != self.dateNameArray[0]{
                                self.newFoodNameArray.removeAll()
                                self.newCalArray.removeAll()
                    }
                    print("testDatearrat*: \(self.dateNameArray)")
                    print("testDate*: \(testDate)")
                    
                    self.newCalArray.append(Int(cals))
                    self.newFoodNameArray.append(foodName)

                    self.foodArray.append(self.calorieArray as [Int])
                    self.dictFood[testDate] = self.newCalArray
                    self.dictName[testDate] = self.newFoodNameArray
                    
                    
                    
                    
                    let sortedArray = self.dictFood.sorted(by: {$1.0 < $0.0})
                    let sortedDictNameArray = self.dictName.sorted(by: {$1.0 < $0.0})
                    
                    
                    
                    ///////not needed?
                    self.sortedArray2 = sortedArray
                    
                    
                    
                    let keys = sortedArray.map {return $0.0 }
//                    let keysDictName = sortedDictNameArray.map {return $0.0 }
                    
                    
                    
                    
//                    print("keysssssss*: \(keys.count)")
//                    print("self.dateNameArrayPRIOR*: \(self.dateNameArray.count)")
                    
                    
                    self.dateNameArray = keys
                    
                    
                    print("dateNameArray*: \(self.dateNameArray.count)")
                    let values = sortedArray.map {return $0.1 }
                    let dictNameValues = sortedDictNameArray.map {return $0.1 }
                    
                    self.foodArray4 = values
                    self.nameArraysOfArrays = dictNameValues
                    print("nameArraysOfArrays*: \(self.nameArraysOfArrays)")
                    
                    
                }
                
                
            }  else if error != nil {
                
                self.dateNameArray.append(contentsOf: ["*Make sure to allow access in settings!*" ])
                
            }
            
            
            for (_, value) in self.sortedArray2 {
                print("*****valueTHISISDICTVALUE\(value)")
                let _value = value
                let newValue = _value.reduce(0,+)
                print("*****newValue\(newValue)")
                self.parsedCalArray.append(newValue)
                
            }
 
            /////Getting Todays Date
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let result = formatter.string(from: date)
            self.todaysDate = self.convertDateFormatter(date: result)
            
            print("timeStamp\(self.todaysDate)")
            ////Top View Count
            if self.dateNameArray == []{
                self.dailyCalories.text = "Calories Today: 0)"

            }else if self.todaysDate != self.dateNameArray[0] {
                
                
                print("%Today: \(self.todaysDate)")
                print("%FirstDayinarray: \(self.dateNameArray)")
                
                 self.dailyCalorieNumber = 0
                } else {
                self.dailyCalorieNumber = self.parsedCalArray[0]
                }
            self.dailyCalories.text = "Calories Today: \(String(self.dailyCalorieNumber))"
            


            self.tableView.reloadData()
            
            
        }
        
    }
    
    /////MY Arrays of Arrays
    var foodArray4 = [[Int]]()
    var nameArraysOfArrays = [[String]]()
    
    
    
    
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
    

}

class DateFoodItem: NSObject {
    var dateNameArray:[String] = []
    
    var  nameArray:[String] = []
    var  fiberArray = [Int]()
    var  calorieArray = [Int]()
    var  saturatedFatsArray = [Int]()
    var  totalFatsArray = [Int]()
    var  sodiumArray = [Int]()
    var sugarArray = [Int]()
    var  cholesterolArray = [Int]()
    var  carbsArray = [Int]()
    var  proteinArray = [Int]()
    var createdAtArray = [Any]()
    var newDateArray:[String] = []
    var insertDate: NSDate = NSDate()
    //createdAtValue
}

var testArray = [DateFoodItem]()

public extension Sequence {
    func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
        var categories: [U: [Iterator.Element]] = [:]
        for element in self {
            let key = key(element)
            if case nil = categories[key]?.append(element) {
                categories[key] = [element]
            }
        }
        return categories
    }
}
