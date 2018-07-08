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
        
        descr.delegate = self
        
        descr.text = "Описание"
        descr.textColor = UIColor.lightGray
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func createBtn(_ sender: UIButton) {
        CheckLogin(name: nameLbl.text!, descr: descr.text!, lon: UserModel.sharedInstance.longitut, att: UserModel.sharedInstance.latitud)
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
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Описание"
            textView.textColor = UIColor.lightGray
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameLbl.resignFirstResponder()
        descr.resignFirstResponder()
    }
    
    func CheckLogin (name:String, descr:String, lon:Double, att:Double){
        let url = URL(string: "http://188.166.82.179/team36/requests/add_quest.php")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let postString = "name=\(name)&descr=\(descr)&lon=\(lon)&att=\(att)"
        print(postString)
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            do {
                if let responseJSON = try JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
                    print("!!!!!!!!!##########!!!!!!!!!!!!!!!!!!!!!!",responseJSON)
                    let a = String(describing: responseJSON["status"]!)
                    print(a)
                    
                    if a  == "1"{
                        
                            let alert = UIAlertController(title: "", message: "Успешно создана", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                                NSLog("The \"OK\" alert occured.")
                            }))
                            self.present(alert, animated: true, completion: nil)
                            
                            
                            self.createBtn.alpha = 0
                            self.shareBtn.alpha = 1
                            self.codeLabel.alpha = 1
                        
                    }
                    else{
                        let alert = UIAlertController(title: "Ошибка", message: "Повторите", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                            NSLog("The \"OK\" alert occured.")
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            catch {
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
}
