//
//  ViewController.swift
//  SwiftImageUploader
//
//  Created by Juan Carlos Garzon on 6/22/16.
//  Copyright © 2016 ZongWare. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    @IBAction func selectImageBtnPressed(sender: UIButton) {
        Party.getParties(1, completion: { result in
            debugPrint(result)
        })
        /*
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
        */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imagePicker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
            
            PhotoShareService.sharedInstance.uploadFile(pickedImage)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}

