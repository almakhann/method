//
//  nameSurnamePage.swift
//  SmartWear
//
//  Created by Serik on 21.11.2017.
//  Copyright © 2017 Serik. All rights reserved.
//

import UIKit

class nameSurnamePage: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var surnameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func backBtn(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtn(_ sender: UIButton) {
        if nameTextField.text != "" && surnameTextField.text != ""{
            UserModel.sharedInstance.name = nameTextField.text!
            UserModel.sharedInstance.surname = surnameTextField.text!
            let loginStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = loginStoryboard.instantiateViewController(withIdentifier: "cityPage") as UIViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        else{
            showErrorAlert(errorMessage: "Заполните поле")
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
        nameTextField.resignFirstResponder()
        surnameTextField.resignFirstResponder()
    }



}
