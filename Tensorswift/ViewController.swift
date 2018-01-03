//
//  ViewController.swift
//  Tensorswift
//
//  Created by Bryan Frederick Marks on 1/9/17.
//  Copyright © 2017 Bryan Frederick Marks. All rights reserved.
//// http://stackoverflow.com/questions/37869963/how-to-use-avcapturephotooutput
import Photos
import MobileCoreServices
import UIKit
import AVFoundation
import AWSS3
import Alamofire
import AWSCore

//import AWSS3


//@available(iOS 10.0, *)
class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, TensorDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVCapturePhotoCaptureDelegate {
    
//    @IBOutlet weak var machineGuess: UILabel!
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var percentageGuess: UILabel!
    @IBOutlet weak var machineGuess2: UILabel!

    
    @IBOutlet weak var machineGuess3: UILabel!
    
    
    @IBOutlet weak var timeOfMealName: UILabel!
    
    @IBOutlet weak var ConfirmedFoodOnView0: UILabel!
    @IBOutlet weak var ConfirmedFoodOnView1: UILabel!
    @IBOutlet weak var ConfirmedFoodOnView2: UILabel!
    @IBOutlet weak var ConfirmedFoodOnView3: UILabel!
    @IBOutlet weak var ConfirmedFoodOnView4: UILabel!
    
    
    @IBOutlet weak var confirmedCalsOnView0: UILabel!
    @IBOutlet weak var confirmedCalOnView1: UILabel!
    @IBOutlet weak var confirmedCalOnView2: UILabel!
    @IBOutlet weak var confirmedCalOnView3: UILabel!
    @IBOutlet weak var confirmedCalOnView4: UILabel!
    
    
    
    var foodCals1:Int = 0
    var fat1:Int = 0
    var satFat1:Int = 0
    var chols1:Int = 0
    var sod1:Int = 0
    var totcarbs1:Int =  0
    var fib1:Int =  0
    var sug1:Int =  0
    var prot1:Int =  0
    var foodArray1  = [Int]()
    
    
    var testView = UIView()
    var capturedImage = UIImageView()
    
    var bridge:TensorBridge = TensorBridge()
    var captureSession = AVCaptureSession()
    
//    ///////////////////////////CAMERA
    var cameraOutput : AVCapturePhotoOutput!
    var previewLayer : AVCaptureVideoPreviewLayer!

    
    var confirmedFoodOnViewArray = ["","","","","",""]
    var confirmedCalsArray = ["","","","","",""]

     private var videoCapture: VideoCapture!
     private var ciContext : CIContext!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        captureSessionTest()
        
        guard let videoCapture = videoCapture else {return}
        videoCapture.startCapture()
        UIApplication.shared.statusBarStyle = .lightContent

           }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        
        removeAllViewText()
    }
    
    func removeAllViewText() {
        self.confirmedFoodOnViewArray.removeAll()
        self.confirmedFoodOnViewArray.append(contentsOf: ["","","","","",""])
        self.ConfirmedFoodOnView0.text = self.confirmedFoodOnViewArray[0]
        self.ConfirmedFoodOnView1.text = self.confirmedFoodOnViewArray[1]
        self.ConfirmedFoodOnView2.text = self.confirmedFoodOnViewArray[2]
        self.ConfirmedFoodOnView3.text = self.confirmedFoodOnViewArray[3]
        self.ConfirmedFoodOnView4.text = self.confirmedFoodOnViewArray[4]
        
        
        self.confirmedCalsArray.removeAll()
        self.confirmedCalsArray.append(contentsOf: ["","","","","",""])
        self.confirmedCalsOnView0.text = self.confirmedCalsArray[0]
        self.confirmedCalOnView1.text = self.confirmedCalsArray[1]
        self.confirmedCalOnView2.text = self.confirmedCalsArray[2]
        self.confirmedCalOnView3.text = self.confirmedCalsArray[3]
        self.confirmedCalOnView4.text = self.confirmedCalsArray[4]
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        removeAllViewText()
        bridge.loadModel()
        bridge.delegate = self
        
        let spec = VideoSpec(fps: 3, size: CGSize(width: 640, height: 480))
        videoCapture = VideoCapture(cameraType: .back,
                                    preferredSpec: spec,
                                    previewContainer: previewView.layer)
     
        videoCapture.imageBufferHandler = {[unowned self] (imageBuffer, timestamp, outputBuffer) in
            self.bridge.runCNN(onFrame: imageBuffer)
            
        }
        
        self.fadeOut(finished: true)
        
       
    }
    
    let duration = 1.5
    
    func fadeIn(finished: Bool) {
        UIView.animate(withDuration: self.duration, delay: 0, options: [.curveEaseInOut], animations: { self.imageDrunkOutlet
            .alpha = 1 } , completion: self.fadeOut)
    }
    
    func fadeOut(finished: Bool) {
        UIView.animate(withDuration: self.duration, delay: 0, options: [.curveEaseInOut], animations: { self.imageDrunkOutlet.alpha = 0 } , completion: self.fadeIn)
    }
    
    var dateNameArray = [String]()
    var newFoodTypeArray = [String]()
    var drunknessArrayofArrays = [[String]]()
    
    var drunkDictName = [String: [String]]()
    
    var todaysDate = ""
    var thisFirstDrunkArray = [String]()
    
    var drunkImageToAdd: UIImage?
    var boolDrunkImage = true
    
    @IBAction func fadeInAndOut(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0.5, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.imageDrunkOutlet.alpha = 0.0
        }, completion: nil)
    }
    
    
    
    @IBOutlet weak var imageDrunkOutlet: UIImageView!
    
    
    var counts:[String:Int] = [:]
    var counts2:[String:Int] = [:]
    var drunkKey = ""
    var drunkValue = 0
    
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


    
    override func viewDidAppear(_ animated: Bool) {
        /////////Checking if first launch///////////////UNMUTE
        removeAllViewText()
        
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
        } else {
            print("First launch, setting UserDefault.")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as! ModelController
        
            self.present(vc, animated: false, completion: nil)
        }
        ///////////////UNMUTE
//        getDrunkness()
        
        showMealTime()
    }
    
    func showMealTime() {
        let hour = Calendar.current.component(.hour, from: Date())
        let minute = Calendar.current.component(.minute, from: Date())
        
        print("hour and minute \(hour):\(minute)")
        
        if (hour > 6 && hour  < 11) {
            print("Bfast")
            self.timeOfMealName.text = "Break Fast"
        } else if (hour >= 11 && hour < 14){
            print("Lunch")
            self.timeOfMealName.text = "Lunch"
        } else if (hour > 18 && hour < 23){
            self.timeOfMealName.text = "Dinner"
            print("Dinner")
        } else {
            print("Snack")
            self.timeOfMealName.text = "Snack"
        }
        
    }
    
    var label = ""
    var secondLabel = ""
    var theOutsideMachineGuessDict = [["":Double()]]
    var thisMachineGuessDict = ["": Double()]
    
    func tensorLabelListUpdated(_ recognizedObjects:[AnyHashable : Any]){
        
        for seenObject in recognizedObjects {
            
            
            //////MULTIPLE GUESSES
            
//            print("seenObject: \(seenObject)")
//            let newSeenObject = seenObject as? [String: Int]()
//            
//            for (key, value) in seenObject {
//                print("\(key) occurs \(value) time(s)")
//            
//            }
            ///////
            let label1 = String(describing: seenObject.key)
            
            let confidence = seenObject.value as! Double
            
            let conPct = (confidence * 100).rounded()
            
            // change the debug confidence here
            if confidence > 0.10 {
                label = label1
//                print("\(conPct)% sure that's a \(label)")
                
                
                self.thisMachineGuessDict[label] = conPct
                
                self.theOutsideMachineGuessDict.append(thisMachineGuessDict)
                let outPut = self.thisMachineGuessDict.sorted(by: { (a, b) in (a.value ) > (b.value ) })
                
                                
//                machineGuess.text = "\(outPut[0].key): \(String (Int(outPut[0].value)))%"
                machineGuess2.text = "\(outPut[0].key): \(String (Int(outPut[0].value)))%"
                machineGuess3.text = "\(outPut[1].key): \(String (Int(outPut[1].value)))%"
//                print("*****machineGuess3.text \(String(describing: outPut))")
//                print("*****machineGuess3.text \(String(describing: outPut[0]))")
//                print("*****machineGuess3.text \(String(describing: outPut[0].key))")
                print("*****machineGuess3.text \(String(describing: outPut[0].value))")
                
                label = outPut[0].key
                secondLabel = outPut[1].key

                }
            
            // change the trigger confidence in the Config file
            if confidence > Config.confidence {
              presentSeenObject(label: label)
            }
        }
        
    }
    
    var thisLabelArray = [String]()
//    var seenDict :[String:Int] = [:]
    
    @IBAction func loginButton(_ sender: Any) {
       performSegue(withIdentifier: "login", sender: sender)
    }
    
    func presentSeenObject(label:String){

        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "webView") as! SeenObjectViewController
        
        vc.stringPassed = label
        print("*****************\(label)")
        
        self.present(vc, animated: false, completion: nil)
        
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
            self.performSegue(withIdentifier: "login", sender: nil)
        }
        
        alertController.addAction(DestructiveAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

    
    
    
    var imageToBePassed : UIImage?
    let stillImageOutput = AVCaptureStillImageOutput()
    
    override func viewDidDisappear(_ animated: Bool){
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        cameraOutput = AVCapturePhotoOutput()
        captureSession.removeOutput(cameraOutput)
//        canAddOutput(cameraOutput)
//        captureSession.addOutput(cameraOutput)
    }
    
    
    func captureSessionTest(){
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        cameraOutput = AVCapturePhotoOutput()
        
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        if let input = try? AVCaptureDeviceInput(device: device) {
            if (captureSession.canAddInput(input)) {
                captureSession.addInput(input)
                if (captureSession.canAddOutput(cameraOutput)) {
                    captureSession.addOutput(cameraOutput)
//                    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//                    previewLayer.frame = previewView.bounds
//                    previewView.layer.addSublayer(previewLayer)
                    captureSession.startRunning()
                }
            } else {
                print("issue here : captureSession.canAddInput")
            }
        } else {
            print("some problem here")
        }
    }
    

    
    var seenVC = SeenObjectViewController()
    
    @IBAction func confirmedFood(_ sender: Any) {
        let mongoIDRetreived = UserDefaults.standard.string(forKey: "mongoID")
        print("***mongoIDRetreived****\(String(describing: mongoIDRetreived))")
        if (mongoIDRetreived == nil){
            noLogin()
        } else {
            

//        captureSessionTest()
//        let delayInSeconds = 0.0
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
//            
//            let settings = AVCapturePhotoSettings()
//            let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
//            let previewFormat = [
//                kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
//                kCVPixelBufferWidthKey as String: 160,
//                kCVPixelBufferHeightKey as String: 160
//            ]
//            settings.previewPhotoFormat = previewFormat
//            self.cameraOutput.capturePhoto(with: settings, delegate: self)
//            
//
//            self.newImage = self.capturedImage.image
//            }
        
        
        if self.confirmedFoodOnViewArray.contains(self.label) {
            print("no")
            
        }else {
        
        self.confirmedFoodOnViewArray.insert(self.label, at: 0)
        
        self.ConfirmedFoodOnView0.text = self.confirmedFoodOnViewArray[0]
        self.ConfirmedFoodOnView1.text = self.confirmedFoodOnViewArray[1]
        self.ConfirmedFoodOnView2.text = self.confirmedFoodOnViewArray[2]
        self.ConfirmedFoodOnView3.text = self.confirmedFoodOnViewArray[3]
        self.ConfirmedFoodOnView4.text = self.confirmedFoodOnViewArray[4]
        
        findCalories(stringPassed: self.label)
        
            self.confirmedCalsOnView0.text = self.confirmedCalsArray[0]
            self.confirmedCalOnView1.text = self.confirmedCalsArray[1]
            self.confirmedCalOnView2.text = self.confirmedCalsArray[2]
            self.confirmedCalOnView3.text = self.confirmedCalsArray[3]
            self.confirmedCalOnView4.text = self.confirmedCalsArray[4]
        }
        
        
        
//        let delayInSeconds1 = 0.5
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds1) {
//        self.uploadToS3()
//        guard let videoCapture = self.videoCapture else {return}
//        videoCapture.startCapture()
//        }
        }
    }
    
    @IBAction func secondGuessConfirmed(_ sender: Any) {
        let mongoIDRetreived = UserDefaults.standard.string(forKey: "mongoID")
        print("***mongoIDRetreived****\(String(describing: mongoIDRetreived))")
        if (mongoIDRetreived == nil){
            noLogin()
        } else {
            
            
            //        captureSessionTest()
            //        let delayInSeconds = 0.0
            //        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            //
            //            let settings = AVCapturePhotoSettings()
            //            let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
            //            let previewFormat = [
            //                kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
            //                kCVPixelBufferWidthKey as String: 160,
            //                kCVPixelBufferHeightKey as String: 160
            //            ]
            //            settings.previewPhotoFormat = previewFormat
            //            self.cameraOutput.capturePhoto(with: settings, delegate: self)
            //
            //
            //            self.newImage = self.capturedImage.image
            //            }
            
            
            if self.confirmedFoodOnViewArray.contains(self.secondLabel) {
                print("no")
                
            }else {
                
                self.confirmedFoodOnViewArray.insert(self.secondLabel, at: 0)
                
                self.ConfirmedFoodOnView0.text = self.confirmedFoodOnViewArray[0]
                self.ConfirmedFoodOnView1.text = self.confirmedFoodOnViewArray[1]
                self.ConfirmedFoodOnView2.text = self.confirmedFoodOnViewArray[2]
                self.ConfirmedFoodOnView3.text = self.confirmedFoodOnViewArray[3]
                self.ConfirmedFoodOnView4.text = self.confirmedFoodOnViewArray[4]
                
                findCalories(stringPassed: self.secondLabel)
                
                self.confirmedCalsOnView0.text = self.confirmedCalsArray[0]
                self.confirmedCalOnView1.text = self.confirmedCalsArray[1]
                self.confirmedCalOnView2.text = self.confirmedCalsArray[2]
                self.confirmedCalOnView3.text = self.confirmedCalsArray[3]
                self.confirmedCalOnView4.text = self.confirmedCalsArray[4]
            }
            
            
            
            //        let delayInSeconds1 = 0.5
            //        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds1) {
            //        self.uploadToS3()
            //        guard let videoCapture = self.videoCapture else {return}
            //        videoCapture.startCapture()
            //        }
        }
        
        
    }
    
    
    var failVC = FailViewController()
    
    @IBAction func failureButton(_ sender: Any) {
        let mongoIDRetreived = UserDefaults.standard.string(forKey: "mongoID")
        print("***mongoIDRetreived****\(String(describing: mongoIDRetreived))")
        if (mongoIDRetreived == nil){
            noLogin()
        } else {
            
            
                    captureSessionTest()
                    let delayInSeconds = 0.1
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            
                        let settings = AVCapturePhotoSettings()
                        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
                        let previewFormat = [
                            kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
                            kCVPixelBufferWidthKey as String: 160,
                            kCVPixelBufferHeightKey as String: 160
                        ]
                        settings.previewPhotoFormat = previewFormat
                        self.cameraOutput.capturePhoto(with: settings, delegate: self)
            
            
                        self.newImage = self.capturedImage.image
                        }
            
                    let delayInSeconds1 = 0.8
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds1) {
//                    self.uploadToS3(bucketName: "fail")
                    guard let videoCapture = self.videoCapture else {return}
                    videoCapture.startCapture()
                    }
        }
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func toTracker(_ sender: Any) {
        let mongoIDRetreived = UserDefaults.standard.string(forKey: "mongoID")
        print("***mongoIDRetreived****\(String(describing: mongoIDRetreived))")
        if (mongoIDRetreived == nil){
            noLogin()
        } else {
            performSegue(withIdentifier: "tracker", sender: nil)
        }
    }
    
    
    @IBAction func toInfoPage(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "infoView") as! InfoViewController
        self.present(vc, animated: false, completion: nil)
    }
    @IBAction func quickAdd(_ sender: Any) {
        func showModal() {
            let modalViewController = QuickAddViewController()
            modalViewController.modalPresentationStyle = .overCurrentContext
            present(modalViewController, animated: true, completion: nil)
        }
    }
    
    ///////camera
    
    // callBack from take picture
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if let error = error {
            print("error occure : \(error.localizedDescription)")
        }
        
        if  let sampleBuffer = photoSampleBuffer,
            let previewBuffer = previewPhotoSampleBuffer,
            let dataImage =  AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer:  sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
            print(UIImage(data: dataImage)?.size as Any)
            
            let dataProvider = CGDataProvider(data: dataImage as CFData)
            let cgImageRef: CGImage! = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: .defaultIntent)
            let image = UIImage(cgImage: cgImageRef, scale: 1.0, orientation: UIImageOrientation.right)
            
            
            
            self.capturedImage.image = image
            print("imageimageimage\(self.capturedImage.image)")
            self.uploadToS3(bucketName: "fail")
        } else {
            print("some error here")
        }
    }
    
    // This method you can use somewhere you need to know camera permission   state
    func askPermission() {
        print("here")
        let cameraPermissionStatus =  AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        
        switch cameraPermissionStatus {
        case .authorized:
            print("Already Authorized")
        case .denied:
            print("denied")
            
            let alert = UIAlertController(title: "Sorry :(" , message: "But  could you please grant permission for camera within device settings",  preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel,  handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        case .restricted:
            print("restricted")
        default:
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: {
                [weak self]
                (granted :Bool) -> Void in
                
                if granted == true {
                    // User granted
                    print("User granted")
                    DispatchQueue.main.async(){
                        //Do smth that you need in main thread
                    }
                }
                else {
                    // User Rejected
                    print("User Rejected")
                    
                    DispatchQueue.main.async(){
                        let alert = UIAlertController(title: "WHY?" , message:  "Camera it is the main feature of our application", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self?.present(alert, animated: true, completion: nil)  
                    } 
                }
            });
        }
    }
    
    func postCaloriesToUser(stringPassed: String){
        let mongoIDRetreived = UserDefaults.standard.string(forKey: "mongoID")
        print("***mongoIDRetreived****\(String(describing: mongoIDRetreived))")
        
        //        let propertyToCheck = (sender as AnyObject).currentTitle!
        if (mongoIDRetreived == nil){
            noLogin()
            
        } else {
            //            performSegue(withIdentifier: "tracker", sender: nil)
            
            
            let parameters: [String: Any] = [
                "type" : stringPassed,
                "calories" : foodArray1[0],
                "satFat" : foodArray1[1],
                "cholesterol": foodArray1[2],
                "sodium": foodArray1[3],
                "totalCarbs": foodArray1[4],
                "fiber": foodArray1[5],
                "sugar": foodArray1[6],
                "protein": foodArray1[7],
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
        }
    }
    
    
    func findCalories(stringPassed:String) {
        
        let stringPassed = stringPassed
        
        print("self.labelself.label\(self.label)")
        
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
        
        
        self.confirmedCalsArray.insert(String(foodArray1[0]), at: 0)
        
        print("self.confirmedCalsArray\(self.confirmedCalsArray)")
        
        
        postCaloriesToUser(stringPassed:stringPassed)
        
//      ///////PASSING VALUE  TO TEXT FOR NUTRITENTIAL CONTENT
//        let foodCals = foodArray1[0]
//        foodCals1 =  foodCals
//        calValue.text = "Calories: \(String(foodCals1))"
//        let fat = foodArray1[1]
//        fat1 = fat
//        totalFatValue.text = "Fat: \(String(fat1))"
//        let satFat = foodArray1[2]
//        satFat1 = satFat
//        satFatValue.text = "Saturated Fats: \(String(satFat1))"
//        let chols = foodArray1[3]
//        chols1 = chols
//        cholesterolValue.text = "Cholesterol: \(String(chols1))"
//        let sod = foodArray1[4]
//        sod1 = sod
//        sodiumValue.text = "Sodium: \(String(sod1))"
//        let totcarbs =  foodArray1[5]
//        totcarbs1 = totcarbs
//        carbValue.text = "Total Carbs: \(String(totcarbs1))"
//        let fib =  foodArray1[6]
//        fib1 = fib
//        fiberValye.text = "Fiber: \(String(fib1))"
//        let sug =  foodArray1[7]
//        sug1 = sug
//        sugarValue.text = "Sugar: \(String(sug1))"
//        let prot =  foodArray1[8]
//        prot1 = prot
//        proteinValue.text = "Protein: \(String(prot1))"
//        
//        
    }
    
    var newImage :  UIImage?
    
    func uploadToS3(bucketName: String){
        
        
        
        let accessKey = "AKIAI4P2GONZH3LSG74Q"
        let secretKey = "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"
        
        let credentialsProvider = AWSStaticCredentialsProvider(accessKey: accessKey, secretKey: secretKey)
        let configuration = AWSServiceConfiguration(region:AWSRegionType.usWest2, credentialsProvider:credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        
        //        let bucketNameWithOut = self.takeSpacesOut(string: self.stringPassed)
        
        let bucketNameWithOut = self.label.removingWhitespaces()
        
        print("self.stringPassed \(self.label)")
        print("bucketNameWithOut \(bucketNameWithOut)")
        
        
        
        let date = Date()
        
        //        let S3BucketName = "testdevdiet"
        let remoteName = self.label + String(describing: date)
        let fileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(remoteName)
        //        let image = UIImage(named: "apple")
        
        print("self.newImage \(self.newImage)")
        
        let newImage = resizeImage(image: self.capturedImage.image!, targetSize: CGSize.init(width: 600, height: 600))
        
        let image = newImage
        let data = UIImageJPEGRepresentation(image, 0.9)
        do {
            try data?.write(to: fileURL)
        }
        catch {}
        
        let uploadRequest = AWSS3TransferManagerUploadRequest()!
        uploadRequest.body = fileURL
        uploadRequest.key = remoteName
        
        if bucketName == "fail" {
            uploadRequest.bucket = "devdietv1fail"
        } else {
        
        uploadRequest.bucket = "devdietv1\(bucketNameWithOut)"
            
        }
        
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
        
        print("newImage\(String(describing: newImage))")
        
        return newImage!
    }

    

//    func getDrunkness(){
//        let mongoIDRetreived = UserDefaults.standard.string(forKey: "mongoID")
//        
//        if (mongoIDRetreived == nil){
//            print("First launch, setting UserDefault.")
//            return
//        }
//        let api = API()
//        let variableString: String = mongoIDRetreived!
//        api.getOrders(section: variableString) { responseObject, error in
//            print("responseObject = \(String(describing: responseObject)); error = \(String(describing: error))")
//            if let response = responseObject {
//                print("JSON is \(response)")
//                let found = response["food"] as? [AnyObject]
//                print("found is \(String(describing: found))")
//                for item in found! {
//                    //                    let cals = (item["calories"] as! NSString).doubleValue
//                    let foodName = (item["type"]!)
//                    let createdAtValue = item["createdAt"]!
//                    //Creating String date
//                    let testDate = self.convertDateFormatter(date: createdAtValue! as! String)
//                    if self.dateNameArray == [] {
//                        print("NIL DATE")
//                    } else if testDate != self.dateNameArray[0]{
//                        self.newFoodTypeArray.removeAll()
//                    }
//                    self.newFoodTypeArray.append(foodName! as! String)
//                    self.drunkDictName[testDate] = self.newFoodTypeArray
//                    
//                    let sortedArray = self.drunkDictName.sorted(by: {$1.0 < $0.0})
//                    
//                    let keys = sortedArray.map {return $0.0 }
//                    self.dateNameArray = keys
//                    
//                    let values = sortedArray.map {return $0.1 }
//                    self.drunknessArrayofArrays = values
//                    print("self.drunknessArrayofArrays**\(self.drunknessArrayofArrays)")
//                    
//                    let thisDrunkArray = self.drunknessArrayofArrays
//                    
//                    
//                    self.thisFirstDrunkArray = thisDrunkArray[0]
//                    
//                    
//                    
//                    for item in self.thisFirstDrunkArray {
//                        self.counts[item] = (self.counts[item] ?? 0) + 1
//                        
//                    }
//                    
//                    
//                    /////Getting Todays Date
//                    let date = Date()
//                    let formatter = DateFormatter()
//                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//                    let result = formatter.string(from: date)
//                    self.todaysDate = self.convertDateFormatter(date: result)
//                    
//                    print("timeStamp\(self.todaysDate)")
//                    print("timeStamp\(self.dateNameArray[0])")
//                    
//                    
//                    
//                    //                    print(counts)  // "[BAR: 1, FOOBAR: 1, FOO: 2]"
//                    //                    if (((counts[] == "Wine" && counts[] < 2) && (counts[] == "Beer" && counts[] < 2)   )){
//                    //                        print("bryan you are drunk as fuck")
//                    //                        //
//                    //                        self.imageDrunkOutlet.image = self.drunkImageToAdd
//                    //                    }
//                    
//                    if self.todaysDate == self.dateNameArray[0] {
//                        for (key, value) in self.counts {
//                            print("\(key) occurs \(value) time(s)")
//                            self.drunkKey = key
//                            self.drunkValue = value
//                            if (((self.drunkKey == "Wine" && self.drunkValue > 3) || (self.drunkKey == "Beer" && self.drunkValue > 2)   )){
//                                print("bryan you are drunk")
//                                self.imageDrunkOutlet.image = UIImage(named: "noDrunkness")
//                                return
//                            }
//                        }
////                    }
//                }
//            }
//        }
//    }
//
//    
 }

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
    }
}


extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}




extension Dictionary {
    func sortedKeys(isOrderedBefore:(Key,Key) -> Bool) -> [Key] {
        return Array(self.keys).sorted(by: isOrderedBefore)
    }
    
    // Slower because of a lot of lookups, but probably takes less memory (this is equivalent to Pascals answer in an generic extension)
    func sortedKeysByValue(isOrderedBefore:(Value, Value) -> Bool) -> [Key] {
        return sortedKeys {
            isOrderedBefore(self[$0]!, self[$1]!)
        }
    }
    
    // Faster because of no lookups, may take more memory because of duplicating contents
    func keysSortedByValue(isOrderedBefore:(Value, Value) -> Bool) -> [Key] {
        return Array(self)
            .sorted() {
                let (_, lv) = $0
                let (_, rv) = $1
                return isOrderedBefore(lv, rv)
            }
            .map {
                let (k, _) = $0
                return k
        }
    }
}
