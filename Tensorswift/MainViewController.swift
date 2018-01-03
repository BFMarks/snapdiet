//
//  MainViewController.swift
//  Tensorswift
//
//  Created by Bryan Marks on 3/26/17.
//  Copyright © 2017 Bryan Frederick Marks. All rights reserved.
//

import UIKit
import WebKit

class MainViewController: UIViewController
{
    
    
    @IBOutlet weak var calsLeft: UILabel!
    
    var newString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        print("You just ate: \(newString)")
//        runUserdata()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func runUserdata(){
        
        enum Gender {
            case Male
            case Female
        }
        typealias User = (gender: Gender, age: Int, weightInKg: Double, heightInCm: Int, bodyfat: Int?)
        //Don’t worry if you use Imperial system for measurements, let’s introduce conversion functions:
        
        func toKg(lbs: Double) -> Double {
            let output = lbs / 2.2
            return output
        }
        
        func toCm(feet: Double, inches: Double) -> Double {
            let cm = feet * 30.48 + inches * 2.54
            return cm
        }
        //Now we can setup our user by simply assigning it to variable:
        
        var user = User(gender: .Male, age: 27, weightInKg: 93, heightInCm: 188, bodyfat: 10)
        
        typealias BMRCalculator = () -> Double
        
        enum ActivityFactor: Double {
            case Sedentary = 1.2 // Little or no exercise and desk job
            case LightlyActive = 1.375 // Light exercise or sports 1-3 days a week
            case ModeratelyActive = 1.55 // Moderate exercise or sports 3-5 days a week
            case VeryActive = 1.725 // Hard exercise or sports 6-7 days a week4
            case ExtremelyActive = 1.9 // Hard daily exercise or sports and physical job
        }
        
        func TDEE(bmrCalculator: BMRCalculator, activityFactor: ActivityFactor) -> Int {
            return Int(bmrCalculator() * activityFactor.rawValue)
        }
        
        func lbm(user: User) -> Double {
            return user.weightInKg * (100.0-Double(user.bodyfat!))/100.0
        }
        
        func BMRCalculatorForUser(user: User) -> BMRCalculator {
            func cunninghamCalculator(user: User) -> BMRCalculator {
                return { 500 + 22 * lbm(user: user) }
            }
            
            func mifflinCalculator(user: User) -> BMRCalculator {
                let genderAdjustment = user.gender == .Male ? 161.0 : -5.0
                return { 10.0 * user.weightInKg + 6.25 * Double(user.heightInCm) + genderAdjustment }
            }
            
            if user.bodyfat != nil {
                return cunninghamCalculator(user: user)
            }
            return mifflinCalculator(user: user)
        }
        
        user = User(gender: .Male, age: 26, weightInKg: 73, heightInCm: 184, bodyfat: 10)
        let tdee = TDEE(bmrCalculator: BMRCalculatorForUser(user: user), activityFactor: ActivityFactor.Sedentary)
        
        let todayCal:Int = 2000
        //let inputCal =
        
        //My function
        func dailyRecomendation(todayCal : Int) -> Int {
            //    return {todayCal - (tdee:tdee)}()
            let recommendedCal:Int = todayCal - tdee
            return recommendedCal
            
        }
        
        let daily = dailyRecomendation(todayCal: todayCal)
        if daily == 0 {
            print("You hit your goal!\(abs(daily)) calories")
        } else if daily < 0 {
            self.calsLeft.text = "You can still eat\(abs(daily)) calories"
            print("You can still eat \(abs(daily)) calories")
        } else  {
            print("You ate a little over your goal yesterday of \(abs(daily))")
        }
        
        
        print("You can maintain your weight by eating \(tdee) kcal daily")
        
        
        func caloriesForWeight(kgs: Double) -> Double {
            return kgs * 7700
        }
        
        typealias Goal = () -> Double
        func bulking(kgPerWeek: Double) -> Goal {
            return {kgPerWeek/7}
        }
        func cutting(kgPerWeek: Double) -> Goal {
            return {kgPerWeek/7}
        }
        
        print("daily deficit: \(caloriesForWeight(kgs: 0.5) / 7.0)")
        
        func dailyCalories(tdee: Int, goal: Goal) -> Int {
            return Int(Double(tdee) + (caloriesForWeight(kgs: goal())))
        }
        
        let target = dailyCalories(tdee: tdee, goal: bulking(kgPerWeek: 0.2))
        print("You should be eating \(target) kcal everyday")
        
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func rootViewController(_ sender: Any) {
         self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
}
