//
//  ordersCell.swift
//  SmartWear
//
//  Created by Serik on 05.12.2017.
//  Copyright © 2017 Serik. All rights reserved.
//

import UIKit

class ordersCell: UITableViewCell {

    
    @IBOutlet var price: UILabel!
    @IBOutlet var deliver: UILabel!
    @IBOutlet var totalPrice: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var describe: UILabel!
    @IBOutlet var basketImage: UIImageView!
    
    @IBOutlet var backview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backview.layer.shadowColor = UIColor.black.cgColor
        backview.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        backview.layer.shadowOpacity = 0.4
        backview.layer.shadowRadius = 0.4
        backview.layer.borderWidth = 0.5
        backview.layer.borderColor = UIColor.gray.cgColor
    }

}
