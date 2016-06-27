//
//  PartyViewController.swift
//  SwiftImageUploader
//
//  Created by Juan Carlos Garzon on 6/26/16.
//  Copyright © 2016 ZongWare. All rights reserved.
//

import Foundation
import UIKit


class PartyViewController: UICollectionViewController{
    
    var parties = [Party]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        Party.getParties(1, completion: {result in
            self.parties = result
            self.collectionView?.reloadData()
        })
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.parties.count
    }
    
    // make a cell for each cell index path
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PartyCell", forIndexPath: indexPath) as! PartyCollectionCell
        
        cell.setParty(self.parties[indexPath.item])
        return cell
    }

    

}
