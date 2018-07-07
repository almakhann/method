//
//  MainPageViewCell.swift
//  SmartWear
//
//  Created by Serik on 24.10.17.
//  Copyright © 2017 Serik. All rights reserved.
//

import UIKit

class MainPageViewCell: UICollectionViewCell {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var decription: UILabel!
    @IBOutlet var price: UILabel!
    
    override func awakeFromNib() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 0.4
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.gray.cgColor
    }
}
