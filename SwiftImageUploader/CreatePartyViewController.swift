//
//  CreatePartyViewController.swift
//  SwiftImageUploader
//
//  Created by Juan Carlos Garzon on 7/3/16.
//  Copyright © 2016 ZongWare. All rights reserved.
//

import Foundation
import UIKit


class CreatePartyViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var slugField: UITextField!
    
    @IBOutlet var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imagePicker.delegate = self
    }
    
    @IBAction func onCameraPressed(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func onCancelPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    @IBAction func onSavePressed(sender: AnyObject) {
        var params:[String:String] = [:]
        params["title"] = titleField.text
        params["slug"] = slugField.text
        
        PhotoShareService.sharedInstance.new(.PARTY,
                                             image: imageView.image!,
                                             params: params, completion: onPartySaved)
    }
    
    func onPartySaved(result:AnyObject) -> Void {
        //If Successfull dismiss
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
            
            PhotoShareService.sharedInstance.uploadFile(.MEDIA, image: pickedImage)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}