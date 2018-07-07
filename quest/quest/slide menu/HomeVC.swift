///
//  UserModel.swift
//  quest
//
//  Created by Serik on 07.07.2018.
//  Copyright © 2018 Serik. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

struct State {
    let name: String
    let long: CLLocationDegrees
    let lat: CLLocationDegrees
}

class HomeVC: BaseViewController,CLLocationManagerDelegate, GMSMapViewDelegate, UITextFieldDelegate {
    @IBOutlet var mapView: GMSMapView!
    
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        GetLocationOnMap()
        
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

    
    func createMarkerPosition(titleMarker: String,  latitude: CLLocationDegrees, longitude: CLLocationDegrees, zoom: Float) {
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: zoom)
        
        self.mapView.camera = camera
        let house = UIImage(named: "men")?.withRenderingMode(.alwaysTemplate)
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
       createMarkerPosition(titleMarker: "Ваше местоположение", latitude: (self.locationManager.location?.coordinate.latitude)!, longitude: (self.locationManager.location?.coordinate.longitude)!, zoom: 16)
        
        locationX = (self.locationManager.location?.coordinate.latitude)!
        locationY = (self.locationManager.location?.coordinate.longitude)!
        self.locationManager.stopUpdatingLocation()
    }
    
    let states = [
        State(name: "Alaska", long: -152.404419, lat: 61.370716),
        State(name: "Alabama", long: -86.791130, lat: 32.806671),
        // the other 51 states here...
    ]
    
    func GetLocationOnMap(){
        for state in states{
            let location = CLLocationCoordinate2D(latitude: state.lat, longitude: state.long)
            print("location: \(location)")
            let marker = GMSMarker()
            marker.position = location
            marker.snippet = state.name
            marker.map = mapView
        }
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
    }
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        mapView.isMyLocationEnabled = true
        mapView.selectedMarker = nil
        return false
    }


}
