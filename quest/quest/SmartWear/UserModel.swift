//
//  UserModel.swift
//  SmartWear
//
//  Created by Serik on 21.11.2017.
//  Copyright © 2017 Serik. All rights reserved.
//

import Foundation

class UserModel {
    static let sharedInstance = UserModel()
    
    var type = Int()
    var name = String()
    var surname = String()
    var pass = String()
    var number = String()
    var id = Int16()
    
    
    var index = [Int]()
    
    var bought = [Section]()
    
    var basket = [Section]()
}


