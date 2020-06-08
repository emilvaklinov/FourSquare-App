//
//  PlaceModel.swift
//  FourSquare
//
//  Created by Emil Vaklinov on 08/06/2020.
//  Copyright © 2020 Emil Vaklinov. All rights reserved.
//

import Foundation
import UIKit

//Creating Singleton

class PlaceModel {
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeAtmotphere = ""
    var placeImage = UIImage()
    
    private init(){}
}
