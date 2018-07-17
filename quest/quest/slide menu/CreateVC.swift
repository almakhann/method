//
//  CreateVC.swift
//  quest
//
//  Created by Serik on 08.07.2018.
//  Copyright © 2018 Serik. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class CreateVC: BaseViewController ,CLLocationManagerDelegate, GMSMapViewDelegate {

    @IBOutlet var createBtn: UIButton!
    @IBOutlet var mapView: GMSMapView!
    

    var locationManager = CLLocationManager()
    var location_x: CLLocationDegrees = 0.0
    var location_y: CLLocationDegrees = 0.0
    

   
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        
        self.navigationItem.title = "Создать Квест"


        
        locationManager.requestAlwaysAuthorization()
        //Your map initiation code
        self.mapView.delegate = self
        self.mapView?.isMyLocationEnabled = true
        self.mapView.settings.myLocationButton = true
        self.mapView.settings.compassButton = true
        self.mapView.settings.zoomGestures = true
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    
    
    @IBAction func pressBtn(_ sender: UIButton) {
        if UserModel.sharedInstance.latitud != 0 && UserModel.sharedInstance.latitud != 0{
            let loginStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = loginStoryboard.instantiateViewController(withIdentifier: "shareVC") as UIViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        else{
            let alert = UIAlertController(title: "Ошибка", message: "Выберите место", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
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
        location_x = latitude
        location_y = longitude
    }
    
    func createMarkerPosition(titleMarker: String,  latitude: CLLocationDegrees, longitude: CLLocationDegrees, zoom: Float) {
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: zoom)
        
        self.mapView.camera = camera
        let house = UIImage(named: "man")?.withRenderingMode(.alwaysTemplate)
        let markerView = UIImageView(image: house)
        let marker = GMSMarker()
        marker.iconView = markerView
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.title = titleMarker
        marker.map = mapView
    }
    
    var locationX: CLLocationDegrees = 0.0
    var locationY: CLLocationDegrees = 0.0
    //MARK: - Location Manager delegates
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error to get location : \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        createMarkerPosition(titleMarker: "Ваше местоположение", latitude: (self.locationManager.location?.coordinate.latitude)!, longitude: (self.locationManager.location?.coordinate.longitude)!, zoom: 17)
        
        locationX = (self.locationManager.location?.coordinate.latitude)!
        locationY = (self.locationManager.location?.coordinate.longitude)!
        self.locationManager.stopUpdatingLocation()
        
        print(locationX, locationY)
    }
    
    
    // MARK: - GMSMapViewDelegate
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        mapView.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        mapView.isMyLocationEnabled = true
        
        if (gesture) {
            mapView.selectedMarker = nil
        }
    }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.isMyLocationEnabled = true
        return false
    }
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("COORDINATE \(coordinate)") // when you tapped coordinate
        createMarker(titleMarker: "Выбранное место", latitude: coordinate.latitude, longitude: coordinate.longitude , zoom: 15)
        
        UserModel.sharedInstance.latitud = coordinate.latitude
        UserModel.sharedInstance.longitut = coordinate.longitude
    }
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        mapView.isMyLocationEnabled = true
        mapView.selectedMarker = nil
        return false
    }

}
