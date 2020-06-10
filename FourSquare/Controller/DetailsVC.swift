//
//  DetailsVC.swift
//  FourSquare
//
//  Created by Emil Vaklinov on 08/06/2020.
//  Copyright © 2020 Emil Vaklinov. All rights reserved.
//

import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController {
    
    @IBOutlet weak var detailsImageView: UIImageView!
    
    @IBOutlet weak var detailsNameLabel: UILabel!
    
    @IBOutlet weak var detailsTypeLabel: UILabel!
    
    @IBOutlet weak var detailsAtmosphereLabel: UILabel!
    
    @IBOutlet weak var detailsMapView: MKMapView!
    
    
    var choosenPlaceId = ""
    var chosenLatitude = Double()
    var chosenLogitude = Double()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromParse()
    }
    
    func getDataFromParse() {
        
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: choosenPlaceId)
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                
            } else {
                if objects != nil {
                    if objects!.count > 0 {
                        let choosenPlaceObject = objects![0]
                        
                        //OBJECTS
                        if let placeName = choosenPlaceObject.object(forKey: "name") as? String {
                            self.detailsNameLabel.text = placeName
                        }
                        if let placeType = choosenPlaceObject.object(forKey: "type") as? String {
                            self.detailsTypeLabel.text = placeType
                        }
                        if let placeAtmosphere = choosenPlaceObject.object(forKey: "atmosphere") as? String {
                            self.detailsAtmosphereLabel.text = placeAtmosphere
                        }
                        
                        if let placeLatitude = choosenPlaceObject.object(forKey: "latitude") as? String {
                            if let placeLatitudeDouble = Double(placeLatitude){
                              self.chosenLatitude = placeLatitudeDouble
                            }
                        }
                        if let placeLongitude = choosenPlaceObject.object(forKey: "longitude") as?
                            String {
                            if let placeLongitudeDouble = Double(placeLongitude) {
                                self.chosenLogitude = placeLongitudeDouble
                            }
                        }
                        // Downloading the image
                        if let imageData = choosenPlaceObject.object(forKey: "image") as? PFFileObject {
                            imageData.getDataInBackground {(data, error) in
                                if error == nil {
                                    if data != nil {
                                        self.detailsImageView.image = UIImage(data: data!)
                                    }
                                }
                            }
                        }
                        // MAPs
                        let location = CLLocationCoordinate2D(latitude: self.chosenLatitude, longitude: self.chosenLogitude)
                        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
                        let region = MKCoordinateRegion(center: location, span: span)
                        self.detailsMapView.setRegion(region, animated: true)
                        
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = location
                        annotation.title = self.detailsNameLabel.text!
                        annotation.subtitle = self.detailsTypeLabel.text!
                        self.detailsMapView.addAnnotation(annotation)
                    }
                }
            }
        }
    }
}
