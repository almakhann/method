//
//  cell.swift
//  quest
//
//  Created by Serik on 16.07.2018.
//  Copyright © 2018 Serik. All rights reserved.
//

import UIKit

class cell: UITableViewCell {

    @IBOutlet var nameLbl: UILabel!
    //@IBOutlet var descrLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        descrLbl.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
