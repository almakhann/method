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
    @IBOutlet var routeBtn: UIButton!
    
    @IBOutlet var infoBtn: UIButton!
    var locationManager = CLLocationManager()
    var locationX: CLLocationDegrees = 0.0
    var locationY: CLLocationDegrees = 0.0
    var a = CLLocationCoordinate2D()
    var polylineArray = [GMSPolyline]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserModel.sharedInstance.getDataFromUserDefault())
        GetQuests()
        
        addSlideMenuButton()
        GetLocationOnMap()
        
        for root: GMSPolyline in self.polylineArray
        {
            if root.userData as! String == "root"
            {
                root.map = nil
            }
        }
        
        routeBtn.alpha = 0
        infoBtn.alpha = 0
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
    @IBAction func pressedInfoBtn(_ sender: UIButton) {
        let loginStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = loginStoryboard.instantiateViewController(withIdentifier: "enterVC") as UIViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func pressRouteBtn(_ sender: UIButton) {
        
        let sessionManager = SessionManager()
        let start = CLLocationCoordinate2D(latitude: locationX, longitude: locationY)
        let end = CLLocationCoordinate2D(latitude: a.latitude, longitude: a.longitude)
        
        sessionManager.requestDirections(from: start, to: end, completionHandler: { (path, error) in
            
            if let error = error {
                print("Something went wrong, abort drawing!\nError: \(error)")
            } else {
                // Create a GMSPolyline object from the GMSPath
                let polyline = GMSPolyline(path: path!)
                
                for root: GMSPolyline in self.polylineArray {
                    if root.userData as! String == "root" {
                        root.map = nil
                    }
                }
                polyline.userData = "root"
                
                // Add the GMSPolyline object to the mapView
                polyline.map = self.mapView
                
                
                // Move the camera to the polyline
                let bounds = GMSCoordinateBounds(path: path!)
                let cameraUpdate = GMSCameraUpdate.fit(bounds, with: UIEdgeInsets(top: 40, left: 15, bottom: 10, right: 15))
                self.mapView.animate(with: cameraUpdate)
                self.polylineArray.append(polyline)
            }
        })
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
        
        State(name: "Alaska", long: 76.956707574427128, lat: 43.24299367019087),
        State(name: "Alabama", long: 76.953467465937138, lat: 43.247557734630718),
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
            infoBtn.alpha = 0
            mapView.selectedMarker = nil
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.isMyLocationEnabled = true
        routeBtn.alpha = 1
        infoBtn.alpha = 1
        a = marker.position
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
    
    //Backend
    func GetQuests (){
        let url = URL(string: "http://188.166.82.179/team36/requests/get_all_quests.php")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let postString = ""
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
                    print("!!!!!!!!!!!!!!!!",responseJSON)
                    print(responseJSON["status"]!)
                    
                    print("################",type(of: responseJSON))
                    
            //        for i in 0...(responseJSON.count){
              //          print(responseJSON["i"]!["name"])
                //    }
                }
            }
            catch {
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
}

class SessionManager {
    let GOOGLE_DIRECTIONS_API_KEY = "AIzaSyDjkWFzuIIqhGuHKfJtnEPL6A8_dmdMt7M"
    
    func requestDirections(from start: CLLocationCoordinate2D, to end: CLLocationCoordinate2D, completionHandler: @escaping ((_ response: GMSPath?, _ error: Error?) -> Void)) {
        guard let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(start.latitude),\(start.longitude)&destination=\(end.latitude),\(end.longitude)&key=\(GOOGLE_DIRECTIONS_API_KEY)") else {
            let error = NSError(domain: "LocalDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to create object URL"])
            print("Error: \(error)")
            completionHandler(nil, error)
            return
        }
        
        // Set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            // Check if there is an error.
            guard error == nil else {
                DispatchQueue.main.async {
                    print("Google Directions Request Error: \((error!)).")
                    completionHandler(nil, error)
                }
                return
            }
            
            // Make sure data was received.
            guard let data = data else {
                DispatchQueue.main.async {
                    let error = NSError(domain: "GoogleDirectionsRequest", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to receive data"])
                    print("Error: \(error).")
                    completionHandler(nil, error)
                }
                return
            }
            
            do {
                // Convert data to dictionary.
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    DispatchQueue.main.async {
                        let error = NSError(domain: "GoogleDirectionsRequest", code: 2, userInfo: [NSLocalizedDescriptionKey: "Failed to convert JSON to Dictionary"])
                        print("Error: \(error).")
                        completionHandler(nil, error)
                    }
                    return
                }
                
                // Check if the the Google Direction API returned a status OK response.
                guard let status: String = json["status"] as? String, status == "OK" else {
                    DispatchQueue.main.async {
                        let error = NSError(domain: "GoogleDirectionsRequest", code: 3, userInfo: [NSLocalizedDescriptionKey: "Google Direction API did not return status OK"])
                        print("Error: \(error).")
                        completionHandler(nil, error)
                    }
                    return
                }

                
                // We only need the 'points' key of the json dictionary that resides within.
                if let routes: [Any] = json["routes"] as? [Any], routes.count > 0, let routes0: [String: Any] = routes[0] as? [String: Any], let overviewPolyline: [String: Any] = routes0["overview_polyline"] as? [String: Any], let points: String = overviewPolyline["points"] as? String {
                    // We need the get the first object of the routes array (route0), then route0's overview_polyline and finally overview_polyline's points object.
                    
                    if let path: GMSPath = GMSPath(fromEncodedPath: points) {
                        DispatchQueue.main.async {
                            completionHandler(path, nil)
                        }
                        return
                    } else {
                        DispatchQueue.main.async {
                            let error = NSError(domain: "GoogleDirections", code: 5, userInfo: [NSLocalizedDescriptionKey: "Failed to create GMSPath from encoded points string."])
                            completionHandler(nil, error)
                        }
                        return
                    }
                } else {
                    DispatchQueue.main.async {
                        let error = NSError(domain: "GoogleDirections", code: 4, userInfo: [NSLocalizedDescriptionKey: "Failed to parse overview polyline's points"])
                        completionHandler(nil, error)
                    }
                    return
                }
            } catch let error as NSError  {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
                return
            }
        }
        task.resume()
    }
}
