//
//  CollectionViewCell.swift
//  NASM-ios-alpha
//
//  Created by Eric  Gilbert on 11/23/15.
//  Copyright © 2015 Eric  Gilbert. All rights reserved.
//

import Foundation
import UIKit


//var textLabel: UILabel?


//@IBOutlet var textLabel: UILabel!
class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var typeLabel: UILabel!
    
    @IBOutlet var typeLabelBar: UIImageView!
    var typeLabelBar2 : UIImageView!
//    var border: CALayer!
//    var textLabel: UILabel!
//    var imageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        imageView = UIImageView()
        contentView.addSubview(imageView)
        
        textLabel = UILabel()
        contentView.addSubview(textLabel)
        
        typeLabel = UILabel()
        contentView.addSubview(typeLabel)
        
        typeLabelBar = UIImageView()
//        contentView.addSubview(typeLabelBar)
        
//        typeLabelBar2 = UIImageView()
//        typeLabelBar2.frame = CGRect(x: 10, y: imageView.frame.size.height + 2, width: typeLabel.frame.size.width, height: 2)
//        contentView.addSubview(typeLabelBar2)
        
//        border = CALayer()
//        let width = CGFloat(2.0)
//        border.borderColor = UIColor.redColor().CGColor
//        border.frame = CGRect(x: 0, y: typeLabel.frame.size.height - width, width: typeLabel.frame.size.width, height: typeLabel.frame.size.height)
//        
//        border.borderWidth = width
//        typeLabel.layer.addSublayer(border)
//        typeLabel.layer.masksToBounds = true


    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}