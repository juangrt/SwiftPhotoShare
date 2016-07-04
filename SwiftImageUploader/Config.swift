//
//  Config.swift
//  SwiftImageUploader
//
//  Created by Juan Carlos Garzon on 7/1/16.
//  Copyright © 2016 ZongWare. All rights reserved.
//

import Foundation


class Config {
    static let sharedInstance = Config()
    
    private let configSetting:[String:AnyObject]
    
    var host:String {
        return configSetting["host"] as! String
    }
    
    private init() {
        configSetting = Config.loadSettingsFile()
    }
    
    private static func loadSettingsFile() -> [String:AnyObject] {
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
        
        return plistData
    }
    
}