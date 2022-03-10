//
//  FetchData.swift
//  Air Quality
//
//  Created by Gino Tasis on 3/9/22.
//

import Foundation

struct FetchData {
    
    let apiKey = "2cc95ffe-2a84-4ce7-8cc4-5b5431bfaca2"
    
    func getCountries() {
        
        let baseURL = "http://api.airvisual.com/v2/countries?key=\(apiKey)"

        
    }
    
    // countries api
    //http://api.airvisual.com/v2/countries?key={{YOUR_API_KEY}}
    
    
    // fetch states
    // http://api.airvisual.com/v2/states?country={{COUNTRY_NAME}}&key={{YOUR_API_KEY}}

 
    // fetch cities
    //http://api.airvisual.com/v2/cities?state={{STATE_NAME}}&country={{COUNTRY_NAME}}&key={{YOUR_API_KEY}}
    
    
    // fetch city detail
    // http://api.airvisual.com/v2/city?city=Los Angeles&state=California&country=USA&key={{YOUR_API_KEY}}

    
    
}
