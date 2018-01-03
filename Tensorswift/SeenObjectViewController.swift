//
//  SeenObjectViewController.swift
//  Tensorswift
//
//  Created by Bryan Frederick Marks on 3/11/17.
//  Copyright © 2017 Bryan Frederick Marks. All rights reserved.
//https://github.com/lbrendanl/SwiftSwipeView

import UIKit
import WebKit
import Alamofire
import AWSS3
import AWSCore


class SeenObjectViewController: UIViewController {

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
    
    @IBOutlet weak var previewImage: UIImageView!
    
    @IBOutlet weak var calValue: UILabel!
    
    @IBOutlet weak var totalFatValue: UILabel!
    
    @IBOutlet weak var satFatValue: UILabel!
    
    @IBOutlet weak var cholesterolValue: UILabel!
    @IBOutlet weak var sodiumValue: UILabel!
    @IBOutlet weak var carbValue: UILabel!
    @IBOutlet weak var fiberValye: UILabel!
    @IBOutlet weak var sugarValue: UILabel!
    @IBOutlet weak var proteinValue: UILabel!
//    @IBOutlet weak var nutrientalValues: UITextView!
    
    @IBOutlet weak var typeOfFood: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        typeOfFood.text = stringPassed
        print("newImage\(String(describing: newImage)) ")
        findCalories()
        
        
        if #available(iOS 10.0, *) {
            let viewCon = ViewController()
            viewCon.capturedImage.image = nil
            
            
        } else {
            // Fallback on earlier versions
        }
        
        ///delay button for one sec
        self.yesMyFood.isEnabled = false
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SeenObjectViewController.enableButton), userInfo: nil, repeats: false)
        
        //delay image
        let delayInSeconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            
            
            self.previewImage.image = self.newImage
            
        }
        
    }
    
    @IBOutlet weak var yesMyFood: UIButton!
    func enableButton() {
        self.yesMyFood.isEnabled = true
    }
    
    var newImage :  UIImage?
    
    var foodArray1  = [Int]()
    
    func findCalories() {
        if stringPassed == "tacos" {
            let foodArray  = [300,18,5,68,1570,41,6,2,6]
            foodArray1 = foodArray as [Int]
        } else if stringPassed == "carrot cake" {
            let foodArray  = [431,16,3,30,320,37,6,27,1]
            foodArray1 = foodArray as [Int]
        } else if stringPassed == "french fries" {
            let foodArray  = [421,22,3,0,389,52,5,1,4]
            foodArray1 = foodArray as [Int]
        } else if stringPassed == "sushi" {
            let foodArray  = [258,9,1,6,538,38,6,3,20]
            foodArray1 = foodArray as [Int]
        } else if stringPassed == "greek salad" {
            let foodArray  = [150,13,0,0,0,6,3,0,3]
            foodArray1 = foodArray as [Int]
        } else if stringPassed == "waffles" {
            let foodArray  = [190,7,15,360,27,9,1,2,2]
            foodArray1 = foodArray as [Int]
        } else if stringPassed == "chicken quesadilla" {
            let foodArray  = [528,27,11,67,1341,43,3,3,27]
            foodArray1 = foodArray as [Int]
        } else if stringPassed == "chicken wings" {
            let foodArray  = [250,8,2,18,19,0,0,0,6]
            foodArray1 = foodArray as [Int]
        } else if stringPassed == "pad thai" {
            let foodArray  = [770,34,5,154,2376,80,6,0,30]
            foodArray1 = foodArray as [Int]
        } else if stringPassed == "hot dog" {
            let foodArray  = [290,26,8,77,1090,5,0,0,10]
            foodArray1 = foodArray as [Int]
        } else if stringPassed == "spaghetti carbonara" {
            let foodArray  = [762,32,19,0,10,5,3,0,35]
            foodArray1 = foodArray as [Int]
        } else if stringPassed == "onion rings" {
            let foodArray  = [411,25,4,0,776,44,3,5,4]
            foodArray1 = foodArray as [Int]
        } else if stringPassed == "pulled pork sandwhich" {
            let foodArray  = [417,11,4,87,1658,47,3,38,38]
            foodArray1 = foodArray as [Int]
        } else if stringPassed == "hamburger" {
            let foodArray  = [750,76,25,173,151,0,0,0,32]
            foodArray1 = foodArray as [Int]
        } else if stringPassed == "caesar salad" {
            let foodArray  = [94,5,3,11,176,9,3,4,7]
            foodArray1 = foodArray as [Int]
        } else if stringPassed == "grilled cheese sandwich" {
            let foodArray  = [497,25,4,7,306,58,3,0,10]
            foodArray1 = foodArray as [Int]
        } else if stringPassed == "guacamole" {
            let foodArray  = [182,17,0,0,0,10,0,0,0]
            foodArray1 = foodArray as [Int]
        } else if stringPassed == "dumplings" {
            let foodArray  = [96,6,2,33,735,6,0,1,6]
            foodArray1 = foodArray as [Int]
        } else if stringPassed == "clam chowder" {
            let foodArray  = [134,2,0,14,1000,19,3,4,7]
            foodArray1 = foodArray as [Int]
        } else if stringPassed == "nachos" {
            let foodArray  = [550,2,0,14,1000,19,3,4,7]
            foodArray1 = foodArray as [Int]
        }


            
            
                ///////[cals, total-fat, sat-fat, Cholestrol, Sodium, Total Carbs, Fiber, Sugar, Protein]
            //works but pretty shit
        else if stringPassed == "ramen" {
            let foodArray  = [250,8,2,18,19,0,0,0,6]
            foodArray1 = foodArray as [Int]
        }
        else {
            let foodArray  = [0,0,0,0,0,0,0,0,0]
            foodArray1 = foodArray as [Int]
            let alert = UIAlertController(title: "Alert", message: "I'm not sure of the nutrientional value", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

        

        
        let foodCals = foodArray1[0]
        foodCals1 =  foodCals
        calValue.text = "Calories: \(String(foodCals1))"
        let fat = foodArray1[1]
        fat1 = fat
        totalFatValue.text = "Fat: \(String(fat1))"
        let satFat = foodArray1[2]
        satFat1 = satFat
        satFatValue.text = "Saturated Fats: \(String(satFat1))"
        let chols = foodArray1[3]
        chols1 = chols
        cholesterolValue.text = "Cholesterol: \(String(chols1))"
        let sod = foodArray1[4]
        sod1 = sod
        sodiumValue.text = "Sodium: \(String(sod1))"
        let totcarbs =  foodArray1[5]
        totcarbs1 = totcarbs
        carbValue.text = "Total Carbs: \(String(totcarbs1))"
        let fib =  foodArray1[6]
        fib1 = fib
        fiberValye.text = "Fiber: \(String(fib1))"
        let sug =  foodArray1[7]
        sug1 = sug
        sugarValue.text = "Sugar: \(String(sug1))"
        let prot =  foodArray1[8]
        prot1 = prot
        proteinValue.text = "Protein: \(String(prot1))"
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            self.performSegue(withIdentifier: "backToLogin", sender: nil)
        }
        
        alertController.addAction(DestructiveAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func yesMyFood(_ sender: Any) {
        
        uploadToS3()
        
        let mongoIDRetreived = UserDefaults.standard.string(forKey: "mongoID")
        print("***mongoIDRetreived****\(String(describing: mongoIDRetreived))")
        
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
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tableView") as! TableViewController
        let newString = String(foodCals1)
        vc.newString = newString
        print("*****************\(foodCals1)")
        
//        self.present(vc, animated: false, completion: nil)
            performSegue(withIdentifier: "confirmTableView", sender: nil)
        
        }
    }
 
    
    var bucketName = ""
    
//    func takeSpacesOut(string:String) -> String {
//        
//        
//        let trimmedString = string.trimmingCharacters(in: .whitespaces)
//        
//        return trimmedString
//    }
// 
    @IBAction func rootViewController(_ sender: Any) {
        
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "rootView") as! ViewController
//        vc.capturedImage.image = nil
        
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
 
    func uploadToS3(){

        
        let accessKey = "AKIAI4P2GONZH3LSG74Q"
        let secretKey = "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"
        
        let credentialsProvider = AWSStaticCredentialsProvider(accessKey: accessKey, secretKey: secretKey)
        let configuration = AWSServiceConfiguration(region:AWSRegionType.usWest2, credentialsProvider:credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        
//        let bucketNameWithOut = self.takeSpacesOut(string: self.stringPassed)
        
        let bucketNameWithOut = self.stringPassed.removingWhitespaces()
        
        print("self.stringPassed \(self.stringPassed)")
        print("bucketNameWithOut \(bucketNameWithOut)")
        
        
        
        let date = Date()
        
//        let S3BucketName = "testdevdiet"
        let remoteName = self.stringPassed + String(describing: date)
        let fileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(remoteName)
//        let image = UIImage(named: "apple")
        
        let newImage = resizeImage(image: self.newImage!, targetSize: CGSize.init(width: 600, height: 600))
        
        let image = newImage
        let data = UIImageJPEGRepresentation(image, 0.9)
        do {
            try data?.write(to: fileURL)
        }
        catch {}
        
        let uploadRequest = AWSS3TransferManagerUploadRequest()!
        uploadRequest.body = fileURL
        uploadRequest.key = remoteName
        uploadRequest.bucket = "devdietv1\(bucketNameWithOut)"
//        uploadRequest.bucket = S3BucketName
        uploadRequest.contentType = "image/jpeg"
        uploadRequest.acl = .publicRead
        
        let transferManager = AWSS3TransferManager.default()
        transferManager?.upload(uploadRequest).continue({ [weak self] (task: AWSTask<AnyObject>) -> Any? in
            DispatchQueue.main.async {
//                self?.uploadButton.isHidden = false
//                self?.activityIndicator.stopAnimating()
            }
            
            if let error = task.error {
                print("Upload failed with error: (\(error.localizedDescription))")
            }
            if let exception = task.exception {
                print("Upload failed with exception (\(exception))")
            }
            
            if task.result != nil {
                let url = AWSS3.default().configuration.endpoint.url
                let publicURL = url?.appendingPathComponent(uploadRequest.bucket!).appendingPathComponent(uploadRequest.key!)
                print("Uploaded to:\(String(describing: publicURL))")
            }
            
            return nil
        })

    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

//extension String {
//    func removingWhitespaces() -> String {
//        return components(separatedBy: .whitespaces).joined()
//    }
//}
