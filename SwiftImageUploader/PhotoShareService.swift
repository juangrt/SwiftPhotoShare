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
class PhotoShareService {
    static let sharedInstance = PhotoShareService()
    
    enum SegmentType {
        case PARTY ,MEDIA , USER
    }
    
    func segment(type:SegmentType) -> String {
        switch type {
        case SegmentType.PARTY:
            return "party"
        case SegmentType.MEDIA:
            return "media"
        case SegmentType.USER:
            return "user"
        }
    }
    
    func segmentUpload(type:SegmentType) -> String {
        switch type {
        case SegmentType.PARTY:
            return "headerImage"
        case SegmentType.MEDIA:
            return "mediaImage"
        case SegmentType.USER:
            return "profileImage"
        }
    }
    
    func new(seg:SegmentType, image: UIImage, params:[String:String],
                                    completion: (result: AnyObject) -> Void) {
        let apiUrl:String = Config.sharedInstance.host + self.segment(seg) + "/new"
        
        let imageData:NSData! = UIImageJPEGRepresentation(image, 1.0)
        
        Alamofire.upload(.POST,
                        apiUrl,
                        multipartFormData:
            { multipartFormData in
                multipartFormData.appendBodyPart(data: imageData!,
                    name: self.segmentUpload(seg), fileName: "upload.jpg" ,
                    mimeType: "image/jpg")
                
                for param in params {
                    multipartFormData.appendBodyPart(data: param.1.dataUsingEncoding(NSUTF8StringEncoding,
                        allowLossyConversion: false)!, name : param.0)
                }
            }, encodingCompletion:
            { encodingResult in
                
                switch encodingResult {
                    case .Success(let upload, _, _):
                        upload.responseJSON { response in
                            debugPrint(response)
                        }
                    case .Failure(let encodingError):
                        print(encodingError)
                }
                
                completion(result: "")
        })
        
    }
    
    func get(seg:SegmentType, page:NSNumber , completion: (result: AnyObject) -> Void) {
        Alamofire.request(.GET , Config.sharedInstance.host + segment(seg)).responseJSON{
            response in switch response.result {
            case .Success(let JSON):
                let partiesRaw = JSON
                completion(result: partiesRaw)
            case .Failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
    
    
    func uploadFile(seg:SegmentType, image: UIImage) {
        let apiUrl:String = Config.sharedInstance.host + self.segment(seg) + "/new"
        
        //Add logic to upload right image representation
        let imageData:NSData! = UIImageJPEGRepresentation(image, 1.0)
        
        Alamofire.upload(.POST,
                         apiUrl,
                         multipartFormData: { multipartFormData in
                            //Appends the image
                            //To Do: Ensure proper mimeType
                            multipartFormData.appendBodyPart(data: imageData!, name: self.segmentUpload(seg), fileName: "upload.jpg" , mimeType: "image/jpg")
                            
                            //To Do: Dynamic keys?
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
    
    
    
    
    
}