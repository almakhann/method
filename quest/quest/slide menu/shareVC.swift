//
//  shareVC.swift
//  quest
//
//  Created by Serik on 08.07.2018.
//  Copyright © 2018 Serik. All rights reserved.
//

import UIKit

class shareVC: UIViewController,UITextViewDelegate {
    
    @IBOutlet var descr: UITextView!
    @IBOutlet var nameLbl: UITextField!
    
    @IBOutlet var shareBtn: UIButton!
    @IBOutlet var createBtn: UIButton!
    @IBOutlet var codeLabel: UILabel!
    var x = CGFloat()
    var y = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareBtn.alpha = 0
        codeLabel.alpha = 0
        createBtn.alpha = 1
        x = descr.frame.size.height
        y = descr.frame.size.height
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func createBtn(_ sender: UIButton) {
        shareBtn.alpha = 1
        codeLabel.alpha = 1
        createBtn.alpha = 0
        print(UserModel.sharedInstance.latitud, UserModel.sharedInstance.longitut)
      
    }
    
    
    @IBAction func pressShareBtn(_ sender: UIButton) {
        let text = codeLabel.text!
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameLbl.resignFirstResponder()
        descr.resignFirstResponder()
    }
    

    
    
    
}
