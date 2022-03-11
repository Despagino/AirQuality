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
            
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let data):
                    self.updateViews(with: data)
                case .failure(let error):
                    print(error)
                    
                }
            }
        }
    }
    
    func updateViews(with cityInfo: EachCityInfo) {
        
        let data = cityInfo.data
        nameLabel.text = "\(data.city), \(data.state), \(data.country)"
        aqiLabel.text = "AQI: \(data.current.pollution.aqius)"
        wsLabel.text = "Windspeed: \(data.current.weather.ws)"
        tpLabel.text = "Temperature: \(data.current.weather.tp)"
        huLabel.text = "Humidity: \(data.current.weather.hu)"
        
        print(data.current.weather)
        
        let coordinates = data.location.coordinates
        if coordinates.count == 2 {
            latLongLabel.text = "Latitude: \(coordinates[1].rounded()), Longitude: \(coordinates[0].rounded())"
        } else {
            latLongLabel.text = "Uknown location"
        }
    }
}
