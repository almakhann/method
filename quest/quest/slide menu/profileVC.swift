//
//  profileVC.swift
//  quest
//
//  Created by Serik on 08.07.2018.
//  Copyright © 2018 Serik. All rights reserved.
//

import UIKit

class profileVC: BaseViewController {

    @IBOutlet var phoneLbl: UITextField!
    @IBOutlet var surnameLbl: UITextField!
    @IBOutlet var nameLabel: UITextField!
    
    var data = [String: Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Профиль"
        
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        addSlideMenuButton()
        data = UserModel.sharedInstance.getDataFromUserDefault()
        phoneLbl.isUserInteractionEnabled = false
        surnameLbl.isUserInteractionEnabled = false
        nameLabel.isUserInteractionEnabled = false
        
        phoneLbl.text = data["phone"] as? String
        surnameLbl.text = (data["name"] as? String)
        nameLabel.text = data["email"] as? String
        // Do any additional setup after loading the view.
    }

    @IBAction func logoutBtn(_ sender: UIButton) {
        UserModel.sharedInstance.removeUserDefault()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "logreg")
        self.present(controller, animated: true, completion: nil)
        
    }
    

}
