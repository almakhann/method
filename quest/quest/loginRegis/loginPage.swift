//
//  loginPage.swift
//
//
//  Created by Serik on 07.06.2018.
//  Copyright © 2017 Serik. All rights reserved.
//

import UIKit
import CoreData

class loginPage: UIViewController,UITextFieldDelegate{

    @IBOutlet var numberTextField: UITextField!
    
    @IBOutlet var passTextField: UITextField!
    var number = ""
    var id = Int16()
    var result = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        numberTextField.delegate = self
        result = 1
        
        CheckLogin(number: "87071997222", password: "123")
    }
    
    
    
    @IBAction func okBtn(_ sender: UIButton) {
        if NumberCheck() == 1 && passTextField.text != ""{
            //let result = CheckLogin(number: numberTextField.text!, password: passTextField.text!)
            
            if result == 1{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "slideMenu")
                self.present(controller, animated: true, completion: nil)
            }
            else{
                showErrorAlert(errorMessage: "Неправильно")
            }
            
        }
        else{
            showErrorAlert(errorMessage: "Заполните поле")
        }
        
    }
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == numberTextField{
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            if text.first == "8"{
                return newLength <= 11
            }
            else{
                return newLength <= 12
            }
        }
        else{
            return true
        }
    }
    
    func NumberCheck() -> Int{
        number = numberTextField.text!
        if(number != ""){
            if(number.count == 11){
                if(String(number.prefix(2)) == "87"){
                    return 1
                }
                else{
                    showErrorAlert(errorMessage: "Номер неправильно")
                    return 0
                }
            }
            if(number.count > 11){
                numberTextField.isUserInteractionEnabled = false
                return 0
            }
            else{
                showErrorAlert(errorMessage: "Номер неправильно")
                return 0
            }
        }
        else{
            showErrorAlert(errorMessage: "Заполните поле")
            return 0
        }
    }

    //##Error caller
    func showErrorAlert(errorMessage: String){
        let showErrorAlert = UIStoryboard(name: "ErrorAlert", bundle: nil).instantiateViewController(withIdentifier: "ErrorAlert") as!  ErrorAlertShow
        showErrorAlert.errorMessageLabel = errorMessage
        self.addChildViewController(showErrorAlert)
        showErrorAlert.view.frame = self.view.frame
        showErrorAlert.view.tag = 1000
        var contains = false
        for view in self.view.subviews{
            if view.tag == 1000{
                contains = true
            }
        }
        
        if contains{
            let errorView = self.view.subviews.last
            errorView?.removeFromSuperview()
        }else{
            self.view.addSubview(showErrorAlert.view)
        }
        showErrorAlert.didMove(toParentViewController: self)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        numberTextField.resignFirstResponder()
        passTextField.resignFirstResponder()
    }
    
    //##backend
    func CheckLogin (number: String, password: String) {
        let url = URL(string: "http://188.166.82.179/team36/request/login.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "Login = \(number) & Password = \(password)"
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
        
    }

    

}
