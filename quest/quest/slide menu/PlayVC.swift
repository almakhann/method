//
//  UserModel.swift
//  quest
//
//  Created by Serik on 07.07.2018.
//  Copyright © 2018 Serik. All rights reserved.
//

import UIKit

class PlayVC: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    
    var quest = ["Qupiya","Altyn Saqa"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserModel.sharedInstance.list = 0 
        addSlideMenuButton()
        print(quest[0])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quest.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! cell
        cell.nameLbl.text = quest[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showme" {
            let destination = segue.destination as! enterVC
            print((tableView.indexPathForSelectedRow?.row)!)
            print(self.quest[(tableView.indexPathForSelectedRow?.row)!], "!!!!!!!!!!!!")
            destination.name = self.quest[(tableView.indexPathForSelectedRow?.row)!]
            destination.my_protocol = self
        }
    }
    

}
