
------

This is Food Recognition App I built with TensorFlow model in a Swift app.  Basic tutorial included but happy to add more if there are enough requested!

## Live DEMO

![Alt Text](https://github.com/BFMarks/snapdiet/blob/master/demo.gif)

*Notice the image accuracy at the bottom left.


## Technology in the project.

 - [TensorFlow](https://github.com/tensorflow/tensorflow)
 - [AlamoFire](https://github.com/Alamofire/Alamofire)
 - [Node.js Backend](https://github.com/balderdashy/sails) (Not Included)
 

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/https://www.paypal.me/bfmarks)
Donations will be put back in tutorials (but please don't feel like it's necessary).

## Background

This app imports a Tensorflow image recognition model into a Swift app and runs the model every third of a second.  The training dataset used to create the model can be found with the [Food 101 Keras Dataset](https://github.com/stratospark/food-101-keras) or the [Food Cam Japanese Dataset](http://foodcam.mobi/dataset100.html).  Since robust training sets are essential in creating accurate models, I also built a script that pulls images from Flickr and used it to add to the dataset (Please feel free to reach out if you would like it).  This project is build in conjenction with [Morten-Just Trainer Mac](https://github.com/mortenjust/trainer-mac/).

## Key Files
### [ViewController.swift](https://github.com/BFMarks/snapdiet/blob/master/Tensorswift/ViewController.swift)
This view contains the bulk of the code that links the video stream with the caloric intake of the identified food.   

```swift
            if confidence > 0.10 {
                label = label1

                machineGuess2.text = "\(outPut[0].key): \(String (Int(outPut[0].value)))%"
                machineGuess3.text = "\(outPut[1].key): \(String (Int(outPut[1].value)))%"
                label = outPut[0].key
                secondLabel = outPut[1].key
                }            
            // change the trigger confidence in the Config file
            if confidence > Config.confidence {
              presentSeenObject(label: label)
            }
        }
```        

### [Config.swift](https://github.com/BFMarks/snapdiet/blob/master/Config.swift)
Allows you to set the confidence variable, which determines when the food is confirmed( ```static var confidence = 0.9```)


### [QuickAddViewController.swift](https://github.com/BFMarks/snapdiet/blob/master/Tensorswift/QuickAddViewController.swift)
This is a really great collection view embedded in a table view to create a very pretty interface.

![alt text](https://www.evernote.com/shard/s689/sh/eb39aeb8-40c7-48fc-a73e-df33ea6a1ce2/ab62f01bb895de2e/res/29baaf54-039f-4ed2-abc6-e7d5dbb8c256/skitch.png?resizeSmall&width=832)

###[Last Points]
This is a fairly large project with a backend written in Node.js (not included) so it may not work as expected with out some dev time.  Please let me know your thoughts!
