//
//  loginPage.swift
//  SmartWear
//
//  Created by Serik on 21.11.2017.
//  Copyright © 2017 Serik. All rights reserved.
//

import UIKit
import CoreData

class loginPage: UIViewController,UITextFieldDelegate{

    @IBOutlet var numberTextField: UITextField!
    
    @IBOutlet var passTextField: UITextField!
    var number = ""
    var id = Int16()
    override func viewDidLoad() {
        super.viewDidLoad()
        numberTextField.delegate = self
    }
    
    
    @IBAction func okBtn(_ sender: UIButton) {
       
        if NumberCheck() == 1 && passTextField.text != ""{
            UserModel.sharedInstance.type = 1
            
            let result = CheckLogin(number: numberTextField.text!, password: passTextField.text!)
            if result == 1{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "tabbar")
                self.present(controller, animated: true, completion: nil)
            }
            else{
                showErrorAlert(errorMessage: "Неправильно")
            }
            
            //let loginStoryboard = UIStoryboard(name: "Main", bundle: nil)
            //let nextVC = loginStoryboard.instantiateViewController(withIdentifier: "smsPage") as UIViewController
            //self.navigationController?.pushViewController(nextVC, animated: true)
        }
        else{
            showErrorAlert(errorMessage: "Заполните поле")
        }
        
    }


    @IBAction func backBtn(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func forgetPass(_ sender: UIButton) {
        if numberTextField.text != ""{
            UserModel.sharedInstance.type = 1
            let loginStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = loginStoryboard.instantiateViewController(withIdentifier: "smsPage") as UIViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        else{
            showErrorAlert(errorMessage: "Заполните номер")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == numberTextField{
            guard let text = textField.text else { return true }
            let newLength = text.characters.count + string.characters.count - range.length
            if text.characters.first == "8"{
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
            if(number.characters.count == 12){
                numberTextField.isUserInteractionEnabled = true
                if(String(number.characters.prefix(3)) == "+77"){
                    return 1
                }
                else{
                    showErrorAlert(errorMessage: "Номер неправильно")
                    return 0
                }
            }
            else if(number.characters.count == 11){
                if(String(number.characters.prefix(2)) == "87"){
                    return 1
                }
                else{
                    showErrorAlert(errorMessage: "Номер неправильно")
                    return 0
                }
            }
            if(number.characters.count > 12){
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
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    func CheckLogin (number: String, password: String) -> Int {
        print(password)
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            //go get the results
            let searchResults = try getContext().fetch(fetchRequest)
            let data = searchResults as [User]
            
            for i in data{
                
                if number == i.number! && password == i.password!{
                    print(i.id)
                    id = i.id
                    UserModel.sharedInstance.id = i.id
                    return 1
                }
            }
        } catch {
            print("Error with request: \(error)")
        }
        return 0
    }
    
    

}
