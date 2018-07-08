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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()

        // Do any additional setup after loading the view.
    }

    @IBAction func logoutBtn(_ sender: UIButton) {
        UserModel.sharedInstance.removeUserDefault()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "logreg")
        self.present(controller, animated: true, completion: nil)
        
    }
    

}
