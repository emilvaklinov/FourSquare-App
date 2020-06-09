//
//  MapVC.swift
//  FourSquare
//
//  Created by Emil Vaklinov on 08/06/2020.
//  Copyright © 2020 Emil Vaklinov. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var choosenLatitude = ""
    var choosenLongitude = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonClicked))
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        recognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(recognizer)
    }
    
    @objc func chooseLocation(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            let touches = gestureRecognizer.location(in: self.mapView)
            let coordiantes = self.mapView.convert(touches, toCoordinateFrom: self.mapView)
            
            let anotation = MKPointAnnotation()
            anotation.coordinate = coordiantes
            anotation.title = PlaceModel.sharedInstance.placeName
            anotation.subtitle = PlaceModel.sharedInstance.placeType
            
            self.mapView.addAnnotation(anotation)
            
            self.choosenLatitude = String(coordiantes.latitude)
            self.choosenLongitude = String(coordiantes.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @objc func saveButtonClicked() {
        // PARSE
    }
    
    @objc func backButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }

}
