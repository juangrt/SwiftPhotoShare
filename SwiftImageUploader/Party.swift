//
//  File.swift
//  SwiftImageUploader
//
//  Created by Juan Carlos Garzon on 6/26/16.
//  Copyright © 2016 ZongWare. All rights reserved.
//

import Foundation
import UIKit

class Party: AnyObject {
    
    var title:String = ""
    var slug:String = ""
    var date:NSDate = NSDate()
    
    
    init(title:String , slug:String, date:NSDate){
        self.title = title
        self.slug = slug
        self.date = date
    }
    
    static func getParties(page:NSNumber, completion: (result: [Party]) -> Void) {
        PhotoShareService.sharedInstance.get(.PARTY, page: page, completion: {result in
            var parties = [Party]()
            
            for partyData in (result as? NSArray)! {
                let theDate:NSDate = DateUtils.stringToDate(partyData["date"] as! String)
                let title:String = partyData["title"] as! String
                let slug:String = partyData["slug"] as! String
                
                let party = Party(title: title, slug: slug, date: theDate)
                
                parties.append(party)
            }
            completion(result: parties)
        })
    }
    
    
}