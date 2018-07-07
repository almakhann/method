//
//  UserModel.swift
//  quest
//
//  Created by Serik on 07.07.2018.
//  Copyright © 2018 Serik. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces
import CoreLocation


class UserModel {
    static let sharedInstance = UserModel()
    

    var checkUserLoggedIn = true
    
    var latitud:  CLLocationDegrees = 0.0
    var longitut:  CLLocationDegrees = 0.0
}

