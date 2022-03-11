//
//  AirQualityData.swift
//  Air Quality
//
//  Created by Gino Tasis on 3/9/22.
//

import Foundation

// MARK: - Getting All The Countries Data
struct Country: Codable {
    //endpoint: https://api.airvisual.com/v2/countries?key={{YOUR_API_KEY}}

        var data: [CountryData]
    }

struct CountryData: Codable {
        let country: String
    }


// MARK: - Getting the ALL the States
//endpoint: https://api.airvisual.com/v2/states?country={{COUNTRY_NAME}}&key={{YOUR_API_KEY}}

struct State: Codable {
    let data: [StateData]
}

struct StateData: Codable {
    let state: String
}


// MARK: - Getting the Cities
//endpoint: https://api.airvisual.com/v2/cities?state={{STATE_NAME}}&country={{COUNTRY_NAME}}&key={{YOUR_API_KEY}}

struct City: Codable {
    let data: [CityData]
    
}

struct CityData: Codable {
    let city: String
    
}


// MARK: - getting the specific info of each city in data as well as the weather
//endpoint: https://api.airvisual.com/v2/city?city=Los Angeles&state=California&country=USA&key={{YOUR_API_KEY}}

struct EachCityInfo: Codable {
    let data: CityInfo
}

struct CityInfo: Codable {
    let city: String
    let state: String
    let country: String
    let location: Location
    let current: Current
}

struct Location: Codable {
    let coordinates: [Double]
}

struct Current: Codable {
    let weather: Weather
    let pollution: Pollution
}

struct Weather: Codable {
    let tp: Int
    let hu: Int
    let wd: Double
    let ws: Double
}
struct Pollution: Codable {
    let aqius: Int
}



