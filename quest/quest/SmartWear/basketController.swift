//
//  basketController.swift
//  SmartWear
//
//  Created by Serik on 22.11.2017.
//  Copyright © 2017 Serik. All rights reserved.
//

import UIKit

class basketController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var emptyView: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var basket: UIButton!
    @IBOutlet var footerView: UIView!
    @IBOutlet var priceLabel: UILabel!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserModel.sharedInstance.basket.count == 0{
            noData()
        }
        else{
            tableView.alpha = 1
            footerView.alpha = 1
            emptyView.alpha = 0
            count = 0
            for i in 0..<UserModel.sharedInstance.basket.count {
                count += UserModel.sharedInstance.basket[i].total
                priceLabel.text = String(count)
            }
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserModel.sharedInstance.basket.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! basketCell
        cell.price.text = UserModel.sharedInstance.basket[indexPath.row].price
        cell.describe.text = UserModel.sharedInstance.basket[indexPath.row].info
        cell.totalPrice.text = String(UserModel.sharedInstance.basket[indexPath.row].total) + "KZT"
        cell.deliver.text = UserModel.sharedInstance.basket[indexPath.row].dostavka
        cell.basketImage.image = UserModel.sharedInstance.basket[indexPath.row].image
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        UserModel.sharedInstance.basket.remove(at: indexPath.row)
        tableView.reloadData()

        for i in 0..<UserModel.sharedInstance.basket.count {
            count = 0
            count += UserModel.sharedInstance.basket[i].total
            priceLabel.text = String(count)
        }
        if UserModel.sharedInstance.basket.count == 0{
            noData()
        }
    }

    @IBAction func buyBtn(_ sender: UIButton) {
        let alertController = UIAlertController(title:"" , message: "Спасибо за покупку", preferredStyle: .alert )
        let defaultAction = UIAlertAction(title: "Ok" , style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: {
            for i in 0..<UserModel.sharedInstance.basket.count{
                UserModel.sharedInstance.bought.append(Section(info:UserModel.sharedInstance.basket[i].info, price: UserModel.sharedInstance.basket[i].price, dostavka: UserModel.sharedInstance.basket[i].price, time: UserModel.sharedInstance.basket[i].time, total: UserModel.sharedInstance.basket[i].total, image: UserModel.sharedInstance.basket[i].image))
            }
            self.noData()
        })
    }

    @IBAction func deleteAllBtn(_ sender: UIButton) {
        noData()
        tableView.reloadData()
    }
    func noData(){
        count = 0
        UserModel.sharedInstance.basket.removeAll()
        view.backgroundColor = UIColor(red: 0.9294, green: 0.9176, blue: 0.9255, alpha: 1.0)
        footerView.alpha = 0
        tableView.alpha = 0
        emptyView.alpha = 1
    }
    
}
