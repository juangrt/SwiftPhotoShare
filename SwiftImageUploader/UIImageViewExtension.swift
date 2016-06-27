//
//  UIImageViewExtension.swift
//  SwiftImageUploader
//
//  Created by Juan Carlos Garzon on 6/27/16.
//  Copyright © 2016 ZongWare. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension UIImage {
    
    static func downloadedFrom(link: String,
                    contentMode mode: UIViewContentMode = .ScaleAspectFill ,
                                completion: (image: UIImage) -> Void)
    {    
        Alamofire.request(.GET, link).response {
        (request , response , data, error) in
            if let image = UIImage(data: data! as NSData) {
                completion(image: image)
            } else {
                completion(image: UIImage())
            }
            
        }
    }
}