//
//  InfoViewController.swift
//  Air Quality
//
//  Created by Gino Tasis on 3/9/22.
//

import UIKit

class InfoViewController: UIViewController {
    
    // MARK: - Properties
    
    var country: String?
    var state: String?
    var city: String?
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aqiLabel: UILabel!
    @IBOutlet weak var wsLabel: UILabel!
    @IBOutlet weak var tpLabel: UILabel!
    @IBOutlet weak var huLabel: UILabel!
    @IBOutlet weak var latLongLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getInfo()

    }
    
    // MARK: - Helper
    
    func getInfo() {
        guard let country = country, let state = state, let city = city else { return }
        AirqualityManager.getCityInfo(forCity: city, forState: state, forCountry: country) { result in
            
            
            
        }
        
    }

}
