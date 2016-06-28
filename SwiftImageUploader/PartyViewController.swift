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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addTapped))
    }
    
    func addTapped(button:UIBarButtonItem) {
        performSegueWithIdentifier("CreateParty", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier {
        case "CreateParty"?:
            let view = navigationItem.rightBarButtonItem!.valueForKey("view")
            //SourceRect needs to be adjusted
            segue.destinationViewController.popoverPresentationController?.sourceRect = (view?.frame)!
        default:
            break
        }
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
