//
//  ordersPage.swift
//  SmartWear
//
//  Created by Serik on 05.12.2017.
//  Copyright © 2017 Serik. All rights reserved.
//

import UIKit

class ordersPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var emptyView: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.9294, green: 0.9176, blue: 0.9255, alpha: 1.0)
    
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        if UserModel.sharedInstance.bought.count == 0{
            tableView.alpha = 0
            emptyView.alpha = 1
            
        }
        else{
            tableView.alpha = 1
            emptyView.alpha = 0
            count = 0
            tableView.reloadData()
        }
    }
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserModel.sharedInstance.bought.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ordersCell
        cell.price.text = UserModel.sharedInstance.bought[indexPath.row].price + "KZT"
        cell.describe.text = UserModel.sharedInstance.bought[indexPath.row].info
        cell.totalPrice.text = String(UserModel.sharedInstance.bought[indexPath.row].total) + "KZT"
        cell.deliver.text = UserModel.sharedInstance.bought[indexPath.row].dostavka
        cell.basketImage.image = UserModel.sharedInstance.bought[indexPath.row].image
        return cell
    }
    

}
