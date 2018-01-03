//
//  QuickAddViewController.swift
//  Tensorswift
//
//  Created by Bryan Marks on 4/18/17.
//  Copyright © 2017 Bryan Frederick Marks. All rights reserved.
//

import UIKit
import WebKit
import Foundation
import AVKit
import AVFoundation
import Alamofire
/////[cals, total fat, sat fat, Cholestrol, Sodium, Total Carbs, Fiber, Sugar, Protein]
class QuickAddViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
        var foodArray = [
                         [["Beer",208,0,0,19,18,0,0,1],["Wine",83,0,0,5,0,0,1,0],["Cola",150,0,0,0,0,0,0,0],["OJ",120,0,0,0,0,0,0,0],["Marg",200,0,0,0,0,0,0,0],["Ice-Coffee",100,0,0,0,0,0,0,0]],
                         [["Banana",80,0,0,0,0,0,0,0],["Popcorn",150,0,0,0,0,0,0,0],["Chips",300,0,0,0,0,0,0,0],["Apple",80,0,0,0,0,0,0,0],["Protein Bar",200,0,0,0,0,0,0,0],["Strawberry",100,0,0,0,0,0,0,0]]
                        ]
    
    var stringPassed = ""
    
    var foodCals1:Int = 0
    var fat1:Int = 0
    var satFat1:Int = 0
    var chols1:Int = 0
    var sod1:Int = 0
    var totcarbs1:Int =  0
    var fib1:Int =  0
    var sug1:Int =  0
    var prot1:Int =  0
    
    
    @IBAction func backToCam(_ sender: Any) {
         self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        

        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        
        self.view.insertSubview(blurEffectView, at: 0)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    

    
    let model = generateRandomData()
    var storedOffsets = [Int: CGFloat]()
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? QuickAddTableCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
     func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? QuickAddTableCell else { return }
        
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! CustomHeaderClass
        headerView.addSubview(headerCell)
        return headerView
    }
    

    
  ////////
//     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Section \(section)"
//    }
    
//     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! CustomHeaderClass
//        headerCell.backgroundColor = UIColor.clear
//        
//        switch (section) {
//        case 0:
//            headerCell.headerLabel.text = "Drinks";
//        //return sectionHeaderView
//        case 1:
//            headerCell.headerLabel.text = "Fruits & Veggies";
//        //return sectionHeaderView
//        case 2:
//            headerCell.headerLabel.text = "Snacks";
//        //return sectionHeaderView
//        default:
//            headerCell.headerLabel.text = "Desserts";
//        }
//        
//        return headerCell
//    }
    
    

    
}

extension QuickAddViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        cell.backgroundColor = model[collectionView.tag][indexPath.item]

        
        
        let logoImages: [UIImage] = [UIImage(named:"beer")!,
                                     UIImage(named:"wine3")!,
                                     UIImage(named:"cola")!,
                                        UIImage(named:"orange-juice")!,
                                        UIImage(named:"marg")!,
                                        UIImage(named:"Iced-Coffee")!]
        let logoImages2: [UIImage] = [UIImage(named:"Banana")!,
                                     UIImage(named:"popcorn")!,
                                     UIImage(named:"chips")!,
                                     UIImage(named:"apple")!,
                                     UIImage(named:"proteinBar")!,
                                     UIImage(named:"strawberry")!]

        
        var logoImages3: [[UIImage]] = [logoImages,logoImages2]

        
        cell.backgroundColor = UIColor.white
        let imageView:UIImageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 75, height: 75)
        imageView.image = logoImages3[collectionView.tag][indexPath.item]
        cell.addSubview(imageView)
        
//        cell.myLabel.text = self.items[indexPath.item]
//        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        
        return cell
    }
    
    
    
    func noLogin() {
        let alertController = UIAlertController(title: "You're Not Logged In!", message: "I'm sorry, you must login to the login page to track your data", preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
        let DestructiveAction = UIAlertAction(title: "We're Sorry", style: UIAlertActionStyle.destructive) {
            (result : UIAlertAction) -> Void in
            print("Destructive")
        }
        
        // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            print("OK")
            self.performSegue(withIdentifier: "backToLogin2", sender: nil)
        }
        
        alertController.addAction(DestructiveAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
//        let rowArray = [collectionView.tag]
//        let columnArray = [indexPath.row]
        
//        let itemArray = foodArray[collectionView.tag]
//        let itemArray2 = foodArray[indexPath.row]
//        print("foodArray[collectionView.tag]*** \(itemArray)")
        let itemArray3 = foodArray[collectionView.tag][indexPath.row]
//        print(" foodArray[indexPath.row]*** \(itemArray2)")
        print("itemArrayitemArray33333*** \(itemArray3)")
//        print("foodArray*** \(foodArray)")
        
        stringPassed = itemArray3[0] as! String
        foodCals1 = itemArray3[1] as! Int
        fat1 = itemArray3[2] as! Int
        satFat1 = itemArray3[3] as! Int
        chols1 = itemArray3[4] as! Int
        sod1 = itemArray3[5] as! Int
        totcarbs1 = itemArray3[6] as! Int
        sug1 = itemArray3[7] as! Int
        prot1 = itemArray3[8] as! Int
        
        let mongoIDRetreived = UserDefaults.standard.string(forKey: "mongoID")
        print("***mongoIDRetreived****\(mongoIDRetreived)")
        
        //        let propertyToCheck = (sender as AnyObject).currentTitle!
        if (mongoIDRetreived == nil){
            noLogin()
            
        } else {
            //            performSegue(withIdentifier: "tracker", sender: nil)
            
            
            let parameters: [String: Any] = [
                "type" : stringPassed,
                "calories" : foodCals1,
                "satFat" : satFat1,
                "cholesterol": chols1,
                "sodium": sod1,
                "totalCarbs": totcarbs1,
                "fiber": fib1,
                "sugar": sug1,
                "protein": prot1,
                "user": mongoIDRetreived as Any
            ]
            
            
            
            Alamofire.request("https://snapdiet.herokuapp.com/food/", method: .post, parameters: parameters, encoding: JSONEncoding.default)
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
            
            //
            //            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tableView") as! TableViewController
            //            let newString = String(foodCals1)
            //            vc.newString = newString
            //            print("*****************\(foodCals1)")
            
            //        self.present(vc, animated: false, completion: nil)
//            performSegue(withIdentifier: "confirmTableView", sender: nil)
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }

        
    }
}
