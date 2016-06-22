//
//  Uploader.swift
//  SwiftImageUploader
//
//  Created by Juan Carlos Garzon on 6/22/16.
//  Copyright © 2016 ZongWare. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

//Make this a singleton class
class Uploader: AnyObject {
    
    //Constructor set up uploader
    static let sharedInstance = Uploader()
    
    
    static func uploadFile(image: UIImage) {
        let host:String = "http://192.168.100.162:3000/party/create"
        
        let imageData:NSData! = UIImageJPEGRepresentation(image, 1.0)
        
        //Alamofire.upload(.POST, host, file: imageUrl)
        Alamofire.upload(.POST,
                         host,
                         multipartFormData: { multipartFormData in
                            multipartFormData.appendBodyPart(data: imageData!, name: "mediaFile", fileName: "upload.jpg" , mimeType: "image/jpg")
                            multipartFormData.appendBodyPart(data:"India".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name :"name")
                        },
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .Success(let upload, _, _):
                                upload.responseJSON { response in
                                    debugPrint(response)
                                }
                            case .Failure(let encodingError):
                                print(encodingError)
                            }
        })
    }
    //Get Server Settings from a config file key value pairs
    
    
    
    
    
}