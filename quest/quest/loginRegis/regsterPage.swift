//
//  regsterPage.swift
//  
//  Quest
//  Created by Serik on 07.06.2018.
//  Copyright © 2017 Serik. All rights reserved.
//

import UIKit
import CoreData

class regsterPage: UIViewController {
    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var passTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var surnameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextBtn(_ sender: UIButton) {
        if numberTextField.text != "" && passTextField.text != ""
            && usernameTextField.text != "" && surnameTextField.text != ""{
            
            register(phone: numberTextField.text!, password: passTextField.text!, name: usernameTextField.text!, surname: surnameTextField.text!)
        }
        else{
            print("Error")
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
        usernameTextField.resignFirstResponder()
        surnameTextField.resignFirstResponder()
    }
    
// Backend
    func register(phone:String,password:String,name: String,surname: String){
        let url = URL(string: "http://188.166.82.179/team36/requests/register.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "Login = \(phone) & Password = \(password) & FullName = \(name) & email = \(surname)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {                                                 // check for fundamental networking error
            print("error=\(String(describing: error))")
        return
        }
    
        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
        print("statusCode should be 200, but is \(httpStatus.statusCode)")
            print("response = \(String(describing: response))")
        }
    
        let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
        }
        task.resume()
        
        
//        let loginStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let nextVC = loginStoryboard.instantiateViewController(withIdentifier: "slideMenu") as UIViewController
//        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
