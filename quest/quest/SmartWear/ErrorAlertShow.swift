//
//  ErrorAlertShow.swift
//  SmartWear
//
//  Created by Serik on 21.11.2017.
//  Copyright © 2017 Serik. All rights reserved.
//

import UIKit

class ErrorAlertShow: UIViewController {
    
    @IBOutlet var errorView: UIView!
    @IBOutlet var errorMessege: UILabel!
    
    var errorMessageLabel = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
        self.errorView.center.y = -self.view.frame.height
        
        showError(message: errorMessageLabel)
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.hideError()
        }
    }
    
    
    func showError(message: String)
    {
        errorMessege.text = message
        UIView.animate(withDuration: 0.3, animations: {
            self.errorView.center.y = self.view.center.y - 35
        });
    }
    
    func hideError()
    {
        UIView.animate(withDuration: 0.3, animations: {
            self.errorView.center.y = -self.view.frame.height
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (touches.first != nil){
            hideError()
        }
        super.touchesBegan(touches, with: event)
    }
}
