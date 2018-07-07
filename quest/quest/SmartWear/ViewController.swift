//
//  ViewController.swift
//  SmartWear
//
//  Created by Serik on 24.10.17.
//  Copyright © 2017 Serik. All rights reserved.
//

struct Section{
    var info: String
    var price: String
    var dostavka: String
    var time: String
    var total: Int
    var image: UIImage
    
    init(info: String, price: String, dostavka: String, time: String, total: Int,image: UIImage) {
        self.info = info
        self.price = price
        self.dostavka = dostavka
        self.time = time
        self.total = total
        self.image = image
    }
}

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {

    @IBOutlet var background: UIView!

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!

    
    var price = ["12500 KZT","14000 KZT","17900 KZT","35000 KZT","23000 KZT","17000 KZT","12000 KZT","9800 KZT","27000 KZT"]
    var images = [UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3"),UIImage(named: "4"),UIImage(named: "5"),UIImage(named: "6"),UIImage(named: "7"),UIImage(named: "8"),UIImage(named: "9")]
    
    
    let decription = ["Вязаный свитер","Текстурированный вязаный свитер","Двубортный жакет","Пальто из смесовой шерсти","Пальто","Комбинезон из крепа","Комбинезон","Байковое платье с капюшоном","Платье из шифона"]
    

    
    
    var data = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        background.alpha = 0
        searchBar.delegate = self
        data = decription
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! MainPageViewCell
      
        cell.image.image = images[indexPath.row]
        cell.decription.text = data[indexPath.row]
        cell.price.text = price[indexPath.row]
        
        return cell
    }
    var text = String()
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell:MainPageViewCell = collectionView.cellForItem(at: indexPath) as! MainPageViewCell
        text = cell.decription.text!
        for i in 0..<decription.count{
            if text == decription[i]{
                UserModel.sharedInstance.index = [Int]()
                UserModel.sharedInstance.index.append(i)
                
                let loginStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let nextVC = loginStoryboard.instantiateViewController(withIdentifier: "infoPage") as UIViewController
                self.navigationController?.pushViewController(nextVC, animated: true)
                
                
            }
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        data = searchText.isEmpty ? decription : decription.filter({(dataString: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            var all = [String]()
            if dataString.range(of: searchText, options: .caseInsensitive) == nil{
                print("kate")
                all.append("kate")
            }
            print(all.count)
            if all.count == 5{
                background.alpha = 1
            }
            else{
                background.alpha = 0
            }
            
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })
        collectionView.reloadData()
    }
    
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.resignFirstResponder()
    }
}

