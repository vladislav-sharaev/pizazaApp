//
//  MapViewController.swift
//  Pizaza
//
//  Created by Vladislav Sharaev on 3/4/20.
//  Copyright © 2020 Vladislav Sharaev. All rights reserved.
//

import UIKit
import MapKit

protocol MapViewControllerDelegate {
    func getAdress(adress: String)
}

class MapViewController: UIViewController {

    let locationManager = CLLocationManager()
    var geocoder: CLGeocoder!
    var locat: CLLocation!
    var delegate: MapViewControllerDelegate?
    
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var adressButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locat = CLLocation()
        geocoder = CLGeocoder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationEnabled()
        adressTextField.delegate = self
            
    }
    
    func checkLocationEnabled() {
        if !CLLocationManager.locationServicesEnabled() {
            showAlert(title: "Служба геолокации отключена", message: "Для работы необходимо включить службу геолокации в настройках", url: URL(string: "App-Prefs:root=LOCATION_SERVICES"))
        } else {
            setUpManager()
            checkAuthorization()
        }
    }
    
    func setUpManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true            
            locationManager.startUpdatingLocation()
            break
        case .denied:
            //Обязательно создать в Info.plist Privace - Location When in use...
            showAlert(title: "Служба геолокации отключена", message: "Для работы необходимо включить службу геолокации в настройках", url: URL(string: UIApplication.openSettingsURLString))
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        @unknown default:
            break
        }
    }
    
    func showAlert(title: String, message: String?, url: URL?) {
        //  "App-Prefs:root=LOCATION_SERVICES"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction((UIAlertAction(title: "Перейти в настройки", style: .default, handler: { (alert) in
            if let url = url {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        })))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func adressFieldAction(_ sender: UITextField) {
        geocoder.geocodeAddressString((sender.text!)) { (placemarks, error) in
            if error != nil {
                print("mapkit error: \(error.debugDescription)")
            }
            
            if placemarks != nil {
                if let placemark = placemarks?.first {
                    let annotation = MKPointAnnotation()
                    annotation.title = self.adressTextField.text!
                    annotation.coordinate = placemark.location!.coordinate
                    
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
        }
    }
    @IBAction func adressButtonAction(_ sender: UIButton) {
        let text = self.adressTextField.text
        delegate?.getAdress(adress: text!)
        navigationController?.popViewController(animated: true)
    }
}

extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
            mapView.setRegion(region, animated: true)
            locat = manager.location
            geocoder.reverseGeocodeLocation(locat!) { (placemarks, error) in
                if error != nil {
                    print("error")
                    return
                }
                
                guard let pm = placemarks else {
                    print ("No placemark")
                    return }
                if pm.count > 0 {
                    let pm = placemarks![0]
                    let adress = pm.country! + ", " + pm.locality! + ", " + pm.subLocality!
                    self.adressTextField.text = adress
                    manager.stopUpdatingLocation()
                    
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAuthorization()
    }
}

extension MapViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
