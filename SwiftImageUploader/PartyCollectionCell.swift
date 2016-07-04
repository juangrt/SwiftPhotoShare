//
//  PartyCell.swift
//  SwiftImageUploader
//
//  Created by Juan Carlos Garzon on 6/27/16.
//  Copyright © 2016 ZongWare. All rights reserved.
//

import Foundation
import UIKit


class PartyCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var partyImage: UIImageView!
    
    var party:Party! {
        didSet {
            configureParty()
        }
    }
    
    func configureParty()  {
        title.text = party.title
        let imageUrl = Config.sharedInstance.host + "party/" + party.slug + "/headerImage"
        
        UIImage.downloadedFrom(imageUrl, completion: { image in
            if (image != nil) {
                self.partyImage.image = image
            }
        })
    }
    
    
}