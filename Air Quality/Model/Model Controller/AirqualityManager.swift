//
//  AirqualityManager.swift
//  Air Quality
//
//  Created by Gino Tasis on 3/9/22.
//

import Foundation


struct AirqualityManager {
    
    let getCountryURL = "https://api.airvisual.com/v2/countries?key=2cc95ffe-2a84-4ce7-8cc4-5b5431bfaca2"


    
    func getCountries() {
        
        let urlString = getCountryURL
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    let countries = self.parseJSON(safeData)
                        print(countries)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> [String] {
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(Country.self, from: data)
            
            let countryArray = decodedData.data
            var arrayToReturn: [String] = []
            
            for country in countryArray {
                let countryName = country.country
                arrayToReturn.append(countryName)
            }
            
            return arrayToReturn
            
        } catch {
            print(error)
            return ["String"]
        }
    }
    
    
}
