//
//  AddPlaceVC.swift
//  FourSquare
//
//  Created by Emil Vaklinov on 08/06/2020.
//  Copyright © 2020 Emil Vaklinov. All rights reserved.
//

import UIKit

class AddPlaceVC: UIViewController {

    @IBOutlet weak var placeNameText: UITextField!
    @IBOutlet weak var placeTypeText: UITextField!
    
    @IBOutlet weak var placeAtmosphereText: UITextField!
    
    @IBOutlet weak var placeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
    }
}
