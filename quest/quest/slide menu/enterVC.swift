//
//  enterVC.swift
//  quest
//
//  Created by Serik on 08.07.2018.
//  Copyright © 2018 Serik. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class enterVC: UIViewController,CLLocationManagerDelegate, GMSMapViewDelegate  {

    @IBOutlet var mapView: GMSMapView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descr: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descr.sizeToFit()
        descr.text = "Если вы один раз отправили ссылку на репо то не надо отравлять обратно с каждым коммитом. Пишите простов эту группу кто сделал коммит"
        createMarker(titleMarker: "Serik", latitude: 43.24299367019087, longitude: 76.956707574427128, zoom: 16)
    }
    
    

    @IBAction func sendBtn(_ sender: Any) {
        
    }
    
    func createMarker(titleMarker: String,  latitude: CLLocationDegrees, longitude: CLLocationDegrees, zoom: Float) {
        mapView.clear()
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: zoom)
        mapView.animate(toViewingAngle: 45)
        self.mapView.camera = camera
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.title = titleMarker
        marker.map = mapView
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameLabel.resignFirstResponder()
        descr.resignFirstResponder()
    }
    

}
