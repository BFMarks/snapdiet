
------

This is Food Recognition App I built with TensorFlow model in a Swift app.  Basic tutorial included but happy to add more if there are enough requested!

## Live DEMO

[![Demo CountPages alpha](https://media.giphy.com/media/3oFzlZ1zrgQ9TXtoXK/giphy.gif)


## Technology in the project.

 - [TensorFlow](https://github.com/tensorflow/tensorflow)
 - [AlamoFire](https://github.com/Alamofire/Alamofire)
 

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/https://www.paypal.me/bfmarks)
Donations will be put back in tutorials (but please don't feel like it's necessary).

## Background

This app imports a Tensorflow image recognition model into a Swift app and runs the model every third of a second.  The training dataset used to create the model can be found with the [Food 101 Keras Dataset](https://github.com/stratospark/food-101-keras) or the [Food Cam Japanese Dataset](http://foodcam.mobi/dataset100.html).  Since robust training sets are essential in creating accurate models, I also built a script that pulls images from Flickr and used it to add to the dataset (Please feel free to reach out if you would like it).  This project is build in conjenction with [Morten-Just Trainer Mac](https://github.com/mortenjust/trainer-mac/).

### Key Files
## [ViewController.swift](https://github.com/BFMarks/snapdiet/blob/master/Tensorswift/ViewController.swift)
This view contains the bulk of the code that links the video stream with the caloric intake of the identified food.   

## [Config.swift](https://github.com/BFMarks/snapdiet/blob/master/Config.swift)
Allows you to set the confidence variable, which determines when the food is confirmed.

## [QuickAddViewController.swift](https://github.com/BFMarks/snapdiet/blob/master/Tensorswift/QuickAddViewController.swift)
This is a really great collection view embedded in a table view to create a very pretty interface.

![alt text](https://www.evernote.com/shard/s689/sh/eb39aeb8-40c7-48fc-a73e-df33ea6a1ce2/ab62f01bb895de2e/res/29baaf54-039f-4ed2-abc6-e7d5dbb8c256/skitch.png?resizeSmall&width=832)

### Swift

```swift
   func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        
        return self.contentArray.count
    }
```
This function sets the number of cells in the Table View.   It is typically set to the ```.count``` of the number of items in the array that holds the data for each cell.


```swift
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    { return cell
    }
    
```
This function displays the data in each cell.  You must have a separate class to contain the cell data, which in this project is ```TableViewCell.swift```.

Lastly, we have the function that plays the video:

```swift
 private  func playVideo(video: String) {
  
    }
```
Finnish soon.
