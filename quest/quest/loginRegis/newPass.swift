//
//  newPass.swift
//  SmartWear
//
//  Created by Serik on 29.11.2017.
//  Copyright © 2017 Serik. All rights reserved.
//

import UIKit

class newPass: UIViewController {

    @IBOutlet var newPass: UITextField!
    @IBOutlet var reNewPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func backBtn(_ sender: UIButton) {
    }
 
    @IBAction func nextBtn(_ sender: UIButton) {
        if newPass.text != "" && reNewPass.text != ""{
            
            if newPass.text == reNewPass.text{
                var viewControllers = navigationController?.viewControllers
                viewControllers?.removeLast(2)
                navigationController?.setViewControllers(viewControllers!, animated: true)
            }
            else{
                showErrorAlert(errorMessage: "Пароли не совпадают")
            }
        }
        else{
            showErrorAlert(errorMessage: "Заполните поле")
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

    

}
