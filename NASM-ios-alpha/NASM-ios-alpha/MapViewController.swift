//
//  MapViewController.swift
//  NASM-ios-alpha
//
//  Created by Eric  Gilbert on 11/24/15.
//  Copyright © 2015 Eric  Gilbert. All rights reserved.
//

import Foundation
import UIKit


class MapViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGrayColor()
        
        let textLabel = UILabel(frame: CGRectMake(0, 0, 200, 30))
        textLabel.center = view.center
        textLabel.textAlignment = .Center
        textLabel.font = UIFont.systemFontOfSize(24)
        textLabel.text = "Map View"
        view.addSubview(textLabel)
    }
}