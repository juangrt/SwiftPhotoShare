//
//  DateUtils.swift
//  SwiftImageUploader
//
//  Created by Juan Carlos Garzon on 6/26/16.
//  Copyright © 2016 ZongWare. All rights reserved.
//

import Foundation

class DateUtils: AnyObject {
    
    static func stringToDate(date:String) -> NSDate {
        let formatter = NSDateFormatter()
        
        // Format 1
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let parsedDate = formatter.dateFromString(date) {
            return parsedDate
        }
        
        // Format 2
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:SSSZ"
        if let parsedDate = formatter.dateFromString(date) {
            return parsedDate
        }
        
        // Couldn't parsed with any format. Just get the date
        let splitedDate = date.componentsSeparatedByString("T")
        if splitedDate.count > 0 {
            formatter.dateFormat = "yyyy-MM-dd"
            if let parsedDate = formatter.dateFromString(splitedDate[0]) {
                return parsedDate
            }
        }
        
        // Nothing worked! Throw Error?
        return NSDate()
    }
}