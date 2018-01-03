//
//  FailViewController.swift
//  Tensorswift
//
//  Created by Bryan Marks on 5/10/17.
//  Copyright © 2017 Bryan Frederick Marks. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import Alamofire
import AWSS3
import AWSCore


class FailViewController: UIViewController {
    
    var stringPassed = ""
    var cameraOutput : AVCapturePhotoOutput!
    var previewLayer : AVCaptureVideoPreviewLayer!
    var newImage :  UIImage?

    @IBOutlet weak var previewImage: UIImageView!
    
//    override func viewDidAppear(_ animated: Bool) {
//      
//        self.previewImage.image = self.newImage
//        
//        print("self.previewImage.image = self.newImage\(self.previewImage.image)")
//        print("self.previewImage.image = self.newImage\(self.newImage)")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = UIColor.clear
//        view.isOpaque = false
//        print("newImage\(String(describing: newImage)) ")
//        
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = self.view.frame
//        
//        self.view.insertSubview(blurEffectView, at: 0)
        
//        let delayInSeconds = 1.0
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
        
        
//        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        self.view.addSubview(previewImage)
        self.previewImage.image = self.newImage
        
        print("self.previewImage.image = self.newImage\(self.previewImage.image)")
        print("self.previewImage.image = self.newImage\(self.newImage)")
        
    }
    
    
    var captureSession = AVCaptureSession()
    let stillImageOutput = AVCaptureStillImageOutput()
    
//    override func viewDidDisappear(_ animated: Bool){
//        captureSession = AVCaptureSession()
//        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
//        cameraOutput = AVCapturePhotoOutput()
//        captureSession.removeOutput(cameraOutput)
//        captureSession.stopRunning()
////        previewLayer.removeFromSuperlayer()
////        captureSession = nil
//        previewLayer = nil
//        //        canAddOutput(cameraOutput)
//        //        captureSession.addOutput(cameraOutput)
//    }
//    
    
    @IBAction func toRootView(_ sender: Any) {
         self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    
    var bucketName = ""
    


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
//        uploadRequest.bucket = "devdietv1\(bucketNameWithOut)"
        uploadRequest.bucket = "devdietv1fail"
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
//
//extension String {
//    func removingWhitespaces() -> String {
//        return components(separatedBy: .whitespaces).joined()
//    }
//}
