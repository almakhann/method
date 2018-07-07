//
//  cityPage.swift
//  SmartWear
//
//  Created by Serik on 21.11.2017.
//  Copyright © 2017 Serik. All rights reserved.
//

import UIKit
import CoreData

class cityPage: UIViewController {

    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    
    var surname = String()
    var name = String()
    var number = String()
    var pass = String()
    var id = Int16()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        id = getId()
        surname = UserModel.sharedInstance.surname
        name = UserModel.sharedInstance.name
        number = UserModel.sharedInstance.number
        pass = UserModel.sharedInstance.pass
        print(UserModel.sharedInstance.name,UserModel.sharedInstance.surname)
    }

 
    @IBAction func nextBtn(_ sender: UIButton) {
        if cityTextField.text != "" && addressTextField.text != ""{
            Register(number: number, pass: pass, id: id, name: name, surname: surname, city: cityTextField.text!, address: addressTextField.text!)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "tabbar")
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        cityTextField.resignFirstResponder()
        addressTextField.resignFirstResponder()
    }
    
    
    //##Backend
    func Register(number: String, pass: String, id: Int16, name: String,surname: String, city: String, address: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let info = User(context:context)
        info.id = id
        info.surname = surname
        info.number = number
        info.password = pass
        info.city = city
        info.address = address
        info.name = name
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    func getId () -> Int16 {
        var id: Int16!
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            //go get the results
            let searchResults = try getContext().fetch(fetchRequest)
            if let ID = searchResults.last?.value(forKey: "id"){
                id = ID as! Int16
            }
        } catch {
            print("Error with request: \(error)")
        }
        return id
    }
    
    

}
