//
//  UserModel.swift
//  quest
//
//  Created by Serik on 07.07.2018.
//  Copyright © 2018 Serik. All rights reserved.
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

    var checkUserLoggedIn = true
}

