//
//  MainPage.swift
//  SmartWear
//
//  Created by Serik on 21.11.2017.
//  Copyright © 2017 Serik. All rights reserved.
//

import UIKit

class MainPage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func registerBtn(_ sender: UIButton) {
        let loginStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = loginStoryboard.instantiateViewController(withIdentifier: "registerPage") as UIViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        let loginStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = loginStoryboard.instantiateViewController(withIdentifier: "loginPage") as UIViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}
