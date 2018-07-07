//
//  regsterPage.swift
//  
//
//  Created by Serik on 07.06.2018.
//  Copyright © 2017 Serik. All rights reserved.
//

import UIKit
import CoreData

class regsterPage: UIViewController {

    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var passTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextBtn(_ sender: UIButton) {
        
        if numberTextField.text != "" && passTextField.text != ""{
//            UserModel.sharedInstance.number = numberTextField.text!
//            UserModel.sharedInstance.pass = passTextField.text!
//            UserModel.sharedInstance.type = 0
            let loginStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = loginStoryboard.instantiateViewController(withIdentifier: "nameSurnamePage") as UIViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        let loginStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = loginStoryboard.instantiateViewController(withIdentifier: "loginPage") as UIViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        numberTextField.resignFirstResponder()
        passTextField.resignFirstResponder()
    }
}
