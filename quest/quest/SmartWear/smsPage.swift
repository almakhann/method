//
//  smsPage.swift
//  SmartWear
//
//  Created by Serik on 21.11.2017.
//  Copyright © 2017 Serik. All rights reserved.
//

import UIKit

class smsPage: UIViewController {

    @IBOutlet var codeTextField: UITextField!
    @IBOutlet var footerImage: UIImageView!
    @IBOutlet var nextButton: UIButton!
    
    var type = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("654723")
        type = UserModel.sharedInstance.type
        if type == 0 {
            nextButton.setTitle("Далее", for: .normal)
        }
        else{
            nextButton.setTitle("Продолжить", for: .normal)
            footerImage.alpha = 0
        }
  
    }
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextBtn(_ sender: UIButton) {
        if type == 0 {
            let loginStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = loginStoryboard.instantiateViewController(withIdentifier: "nameSurnamePage") as UIViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        else{
            if codeTextField.text != ""{
                if codeTextField.text == "654723"{
                    let loginStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let nextVC = loginStoryboard.instantiateViewController(withIdentifier: "newPass") as UIViewController
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
                else{
                    showErrorAlert(errorMessage: "Неправильно")
                }
            }
            else{
                showErrorAlert(errorMessage: "Заполните поле")
            }
            
        }
    }
    

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
        codeTextField.resignFirstResponder()
    }

}
