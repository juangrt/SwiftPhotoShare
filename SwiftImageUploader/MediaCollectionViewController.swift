//
//  MediaCollectionViewController.swift
//  SwiftImageUploader
//
//  Created by Juan Carlos Garzon on 7/1/16.
//  Copyright © 2016 ZongWare. All rights reserved.
//

import Foundation
import UIKit


class MediaCollectionViewController: UIViewController {
    
    
    var detailItem: Party! {
        return (self.navigationController as! MediaNavigationViewController).currentParty
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            self.title = "party/" + detail.slug
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

}