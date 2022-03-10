//
//  NetworkError.swift
//  Air Quality
//
//  Created by Gino Tasis on 3/10/22.
//

import Foundation

enum NetworkError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach the server"
        case .thrownError(_):
            return "Error"
        case .noData:
            return "No data in server"
    }
    }
}


//    func getCountries() {
//
//        let urlString = getCountryURL
//
//        if let url = URL(string: urlString) {
//            let session = URLSession(configuration: .default)
//
//            let task = session.dataTask(with: url) { data, response, error in
//                if error != nil {
//                    print(error!)
//                    return
//                }
//
//                if let safeData = data {
//                    let countries = self.parseJSON(safeData)
//                        print(countries)
//                }
//            }
//            task.resume()
//        }
//    }

//    func parseJSON(_ data: Data) -> [String] {
//
//        let decoder = JSONDecoder()
//
//        do {
//            // get all the countries
//            let countryData = try decoder.decode(Country.self, from: data)
//
//            let countryArray = countryData.data
//            var arrayToReturn: [String] = []
//
//            for country in countryArray {
//                let countryName = country.country
//                arrayToReturn.append(countryName)
//            }
//            return arrayToReturn
//
//        } catch {
//            print(error)
//            return ["String"]
//        }
//    }
