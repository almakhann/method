//
//  SettingPage.swift
//  SmartWear
//
//  Created by Serik on 31.10.17.
//  Copyright © 2017 Serik. All rights reserved.
//

import UIKit
import CoreData

class SettingPage: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet var headerView: UIView!
    @IBOutlet var editBtn: UIButton!
    
    @IBOutlet var name: UITextField!
    @IBOutlet var surname: UITextField!
    @IBOutlet var phone: UITextField!
    @IBOutlet var city: UITextField!
    @IBOutlet var address: UITextField!
    @IBOutlet var logOut: UIButton!

    var isChecked: Bool = false
    var imagePicker: UIImagePickerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetData(id: UserModel.sharedInstance.id)
        isChecked = false
        //profilePhoto.layer.masksToBounds = true
        //profilePhoto.layer.cornerRadius = 23
        //profilePhoto.image = UIImage(named: "wallpaper" )
        headerView.layer.borderWidth = 0.5
        headerView.layer.borderColor = UIColor.gray.cgColor
        phone.isUserInteractionEnabled = false
  
    }
    @IBAction func fagPressed(_ sender: UIButton) {
        let loginStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = loginStoryboard.instantiateViewController(withIdentifier: "faq") as UIViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func ChangeImage(_ sender: UIButton) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
                
    }
    
    @IBAction func EditBtnPressed(_ sender: UIButton) {
        if isChecked{
            if name.text != "" && surname.text != ""  && phone.text != "" && city.text != "" && address.text != ""{
                isChecked = !isChecked
                disableBtn(yes: false)
            }
            else{
                let alertController = UIAlertController(title:"Упс!" , message: "Заполни поля", preferredStyle: .alert )
                let defaultAction = UIAlertAction(title: "Да" , style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        else {
            disableBtn(yes: true)
            isChecked = !isChecked
        }
    }
    @IBAction func MyOrders(_ sender: UIButton) {
        let loginStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = loginStoryboard.instantiateViewController(withIdentifier: "myOrders") as UIViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func logOutBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "logreg")
        self.present(controller, animated: true, completion: nil)
    }
  
    func disableBtn(yes: Bool){
        if yes{
            editBtn.setImage(UIImage(named: "checked"), for: .normal)
            //imageChangeBtn.setImage(UIImage(named: "camera"), for: .normal)
            //imageChangeBtn.isEnabled = true
            name.isUserInteractionEnabled = true
            surname.isUserInteractionEnabled = true
            city.isUserInteractionEnabled = true
            address.isUserInteractionEnabled = true
            logOut.alpha = 0
        }
        else{
            editBtn.setImage(UIImage(named: "pencil"), for: .normal)
            //imageChangeBtn.setImage(UIImage(named: ""), for: .normal)
            //imageChangeBtn.isEnabled = false
            name.isUserInteractionEnabled = false
            surname.isUserInteractionEnabled = false
            city.isUserInteractionEnabled = false
            address.isUserInteractionEnabled = false
            logOut.alpha = 1
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        name.resignFirstResponder()
        surname.resignFirstResponder()
        phone.resignFirstResponder()
        city.resignFirstResponder()
        address.resignFirstResponder()
    }
    
    
    //Backend
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    func GetData (id: Int16) -> Int {
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            //go get the results
            let searchResults = try getContext().fetch(fetchRequest)
            let data = searchResults as [User]
            
            for i in data{
                print(i)
                if id == i.id{
                    name.text = i.name
                    surname.text = i.surname
                    city.text = i.city
                    address.text = i.address
                    phone.text = i.number
                    return 1
                }
            }
        } catch {
            print("Error with request: \(error)")
        }
        return 0
    }
}
