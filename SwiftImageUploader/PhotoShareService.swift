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
class PhotoShareService: AnyObject {
    
    internal func segment(type:SegmentType) -> String {
        switch type {
        case SegmentType.PARTY:
            return "party"
        case SegmentType.MEDIA:
            return "media"
        case SegmentType.USER:
            return "user"
        }
    }
    
    enum SegmentType {
        case PARTY ,MEDIA , USER
    }
    
    
    static let sharedInstance = PhotoShareService()
    private let hostKey = "host"
    private let host:String
    
    //To Do: Refactor pList reading
    //Not a fan of this meathod of pList reading
    //Method from https://makeapppie.com/2016/02/11/how-to-use-property-lists-plist-in-swift/
    init() {
        var format = NSPropertyListFormat.XMLFormat_v1_0
        var plistData:[String:AnyObject] = [:]
        
        let infoPlistPath:String? = NSBundle.mainBundle().pathForResource("config" , ofType: "plist")!
        let config = NSFileManager.defaultManager().contentsAtPath(infoPlistPath!)!
        
        do{
            plistData = try NSPropertyListSerialization.propertyListWithData(config,
                                                                             options: .MutableContainersAndLeaves,
                                                                             format: &format)
                as! [String:AnyObject]
        }
        catch{
            print("Error reading plist: \(error), format: \(format)")
        }

        self.host = plistData[hostKey] as! String
    }
    
    func get(seg:SegmentType, page:NSNumber , completion: (result: AnyObject) -> Void) {
        print(self.host + segment(seg))
        
        Alamofire.request(.GET , self.host + segment(seg)).responseJSON{
            response in switch response.result {
            case .Success(let JSON):
                let partiesRaw = JSON
                completion(result: partiesRaw)
            case .Failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
    
    
    func uploadFile(image: UIImage) {
        let apiUrl:String = self.host + "party/new"
        
        //Add logic to upload right image representation
        let imageData:NSData! = UIImageJPEGRepresentation(image, 1.0)
        
        Alamofire.upload(.POST,
                         apiUrl,
                         multipartFormData: { multipartFormData in
                            multipartFormData.appendBodyPart(data: imageData!, name: "headerImage", fileName: "upload.jpg" , mimeType: "image/jpg")
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