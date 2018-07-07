//
//  infoPage.swift
//  SmartWear
//
//  Created by Serik on 05.12.2017.
//  Copyright © 2017 Serik. All rights reserved.
//

import UIKit

class infoPage: UIViewController {

    @IBOutlet var header: UILabel!
    @IBOutlet var image: UIImageView!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var color: UILabel!
    @IBOutlet var dostavka: UILabel!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var totalPrice: UILabel!
    
    
    var total = Int()
    var index = Int()
    
    
    var price = ["12500 KZT","14000 KZT","17900 KZT","35000 KZT","23000 KZT","17000 KZT","12000 KZT","9800 KZT","27000 KZT"]
    var prices = ["12500","14000","17900","35000","23000","17000","12000","9800","27000"]
    
    
    
    var images = [UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3"),UIImage(named: "4"),UIImage(named: "5"),UIImage(named: "6"),UIImage(named: "7"),UIImage(named: "8"),UIImage(named: "9")]
    
    
    let decription = ["Вязаный свитер","Текстурированный вязаный свитер","Двубортный жакет","Пальто из смесовой шерсти","Пальто","Комбинезон из крепа","Комбинезон","Байковое платье с капюшоном","Платье из шифона"]

    
    let info = ["Мягкий, вязаный свитер с содержанием шерсти. Ребристая водолазка, сильно опущенные плечи и широкие рукава с узкими манжетами. 63% акрила, 32% нейлона, 5% шерсти. Машинная стирка холодной водой импортный",
                "Широко разрезанный, слегка более короткий свитер в ткани с текстурой. Выпало плечи и ребра на вырезе, манжетах и подол.75% акрила, 25% хлопка. Машинная стирка холодной водойимпортный",
                "Приталенный жакет из слегка эластичной ткани с воротником и лацканами, а также двубортной застежкой спереди. Прорезные передние карманы. Декоративная застежка снизу на рукавах и шлица сзади. На подкладке.",
                "STUDIO COLLECTION. Прямое двубортное пальто из смесовой шерсти с отложным воротником с отворотом по лацканам, нагрудным карманом, передними карманами с клапаном и потайным карманом. Пуговицы внизу рукава и высокая шлица сзади. На подкладке.",
                "Двубортное пальто из плотной ткани с воротником, заниженной линией плеча, длинными рукавами и потайными боковыми карманами. На подкладке.Подкладка: Полиэстер 95%; Эластан 5%Полиэстер 62%; Шерсть 38%",
                "Комбинезон длиной до щиколотки из креповой ткани с отложным воротником с отворотом по лацкану. Верх на запахе с потайной кнопкой, сзади потайная молния. Талия отрезная со съемным поясом, боковые карманы, прямые широкие брючины.",
                "Длинный комбинезон из жатой ткани в набивную полоску. Резинка сверху и лямки, которые можно завязать вместе. Отрезная модель с вафельной резинкой на талии и широкими прямыми штанинами.",
                "Короткое широкое платье из легкого футера. На платье капюшон на трикотажной подкладке с кулиской. Заниженная линия плеча и широкие рукава длиной три четверти. Удлиненная спинка.",
                "Платье длиной до середины икры из шифона с рисунком. Сзади на шее разрез на пуговице. Рукава плиссе. Отрезная талия на тонкой резинке и плиссированная юбка клеш. На подкладке."
    ]
    
    let colors = ["Ярко-красный","Темно-синий","Темно-зеленый","Серый меланж","Желтый","Черный","Оранжевый","Светло-серый меланж","Черный/Красные цветы"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        index = UserModel.sharedInstance.index[0]
        totalPrice.text = price[index]
        image.image = images[index]
        headerLabel.text = decription[index]
        infoLabel.text = info[index]
        color.text = colors[index]
        dostavka.text = "Бесплатно"
        
        total = Int(prices[index])!
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func toBasket(_ sender: UIButton) {
        let alertController = UIAlertController(title:"" , message: "Добавлено в корзину", preferredStyle: .alert )
        let defaultAction = UIAlertAction(title: "Ok" , style: .cancel, handler: {
        action in
            UserModel.sharedInstance.basket.append(Section(info: self.header.text!,price: self.totalPrice.text! , dostavka: self.dostavka.text!, time: "12 - 14 дней" , total: self.total,image: self.image.image!))
            self.navigationController?.popToRootViewController(animated: true)
        })
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }

}
