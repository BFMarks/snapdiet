////
////  CalBurnController.swift
////  Tensorswift
////
////  Created by Bryan Marks on 3/26/17.
////  Copyright © 2017 Bryan Frederick Marks. All rights reserved.
////
//
//import UIKit
//import CoreMotion
//class CalBurnController: UIViewController {
//    
//    @IBOutlet weak var activityState: UILabel!
//    @IBOutlet weak var steps: UILabel!
//    
//    var days:[String] = []
//    var stepsTaken:[Int] = []
//    
//    @IBOutlet weak var stateImageView: UIImageView!
//    let activityManager = CMMotionActivityManager()
//    let pedoMeter = CMPedometer()
//    
//    override func viewDidLoad() {
//        
//        super.viewDidLoad()
//        
//        var cal = NSCalendar.current
//       let comps = cal.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: NSDate())
//        comps.hour = 0
//        comps.minute = 0
//        comps.second = 0
//        let timeZone = NSTimeZone.system
//        cal.timeZone = timeZone
//        
//        let midnightOfToday = cal.dateFromComponents(comps)!
//        
//        
//        if(CMMotionActivityManager.isActivityAvailable()){
//            self.activityManager.startActivityUpdatesToQueue(OperationQueue.mainQueue, withHandler: { (data: CMMotionActivity!) -> Void in
//                dispatch_get_main_queue().asynchronously(execute: { () -> Void in
//                    if(data.stationary == true){
//                        self.activityState.text = "Stationary"
//                        self.stateImageView.image = UIImage(named: "Sitting")
//                    } else if (data.walking == true){
//                        self.activityState.text = "Walking"
//                        self.stateImageView.image = UIImage(named: "Walking")
//                    } else if (data.running == true){
//                        self.activityState.text = "Running"
//                        self.stateImageView.image = UIImage(named: "Running")
//                    } else if (data.automotive == true){
//                        self.activityState.text = "Automotive"
//                    }
//                })
//                
//            } as! CMMotionActivityHandler
//            
//            
//            
//            
//            )
//        }
//        if(CMPedometer.isStepCountingAvailable()){
//            let fromDate = NSDate(timeIntervalSinceNow: -86400 * 7)
//            self.pedoMeter.queryPedometerDataFromDate(fromDate as Date, toDate: NSDate() as Date) { (data : CMPedometerData!, error) -> Void in
//                println(data)
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    if(error == nil){
//                        self.steps.text = "\(data.numberOfSteps)"
//                    }
//                })
//                
//            } as! CMPedometerHandler
//            
//            self.pedoMeter.startPedometerUpdatesFromDate(midnightOfToday) { (data: CMPedometerData!, error) -> Void in
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    if(error == nil){
//                        self.steps.text = "\(data.numberOfSteps)"
//                    }
//                })
//            }
//        }
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        
//    }
//    
//    
//}
//
