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
    

    // BACKEND
    func register(phone:String,password:String,name: String,surname: String){
        let url = URL(string: "http://188.166.82.179/team36/requests/register.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postString = "username=\(phone)&password=\(password)&fullname=\(name)&email=\(surname)"
        print(postString)
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            do {
                if let responseJSON = try JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
                    print(responseJSON)
                    print(responseJSON["status"]!)
                    let a = String(describing: responseJSON["status"]!)
                    if a  == "1"{
                        DispatchQueue.main.async {
                            
                            
                            let loginStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let nextVC = loginStoryboard.instantiateViewController(withIdentifier: "loginPage") as UIViewController
                            self.navigationController?.pushViewController(nextVC, animated: true)
                            
                        }
                    }
                }
            }
            catch {
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
}
