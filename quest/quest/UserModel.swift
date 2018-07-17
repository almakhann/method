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
    
    var latitud:  CLLocationDegrees = 0.0
    var longitut:  CLLocationDegrees = 0.0
    
    
    var list = Int()
    
    func saveUserDict(dict: Dictionary<String, Any>) {
        UserDefaults.standard.set(dict, forKey: "user")
    }
    
    func removeUserDefault() {
        UserDefaults.standard.removeObject(forKey: "user")
    }
    
    var empty = [String: Any]()
    func getDataFromUserDefault() -> [String: Any] {
        let retrieveDict = UserDefaults.standard.dictionary(forKey:"user")
        if(retrieveDict != nil){
            return retrieveDict!
        }
        else{
            return empty
        }
    }
    
    func checkUserLoggedIn() -> Bool {
        if(getDataFromUserDefault().isEmpty){
            return false
        }
        else{
            return true
        }
    }
    
    
    
    
    
}

