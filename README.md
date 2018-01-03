
------

This is Food Recognition App I built with TensorFlow in Swift.  Basic tutorial included but happy to add more if there are enough requested!

## Live DEMO

![alt text](https://media.giphy.com/media/3oFzmbLykQykqDc7gQ/giphy.gif)


## These are the technology in the project.

 - [TensorFlow](https://github.com/tensorflow/tensorflow)
 - [AlamoFire](https://github.com/Alamofire/Alamofire)
 

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/https://www.paypal.me/bfmarks)
Donations will be put back in tutorials (but please don't feel like it's necessary).

## Installation

### Install the SDK's by opening terminal to root directory of your project.

    pod install

### Open the Xcode Workspace (not the project)

    Recovery.xcworkspace



## [Treatment Table View](https://github.com/BFMarks/Recovery/blob/master/RecoveryAI/TableViewController.swift)


![alt text](https://www.evernote.com/shard/s689/sh/9ab12a82-2210-4c7a-992f-4f71499a0596/644a60765f62f2e9/res/779b2d62-74e7-4f31-9aa3-d10c51290e01/skitch.png?resizeSmall&width=832)

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
