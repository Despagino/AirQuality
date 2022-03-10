//
//  AirqualityManager.swift
//  Air Quality
//
//  Created by Gino Tasis on 3/9/22.
//

import Foundation


struct AirqualityManager {
    
    let getCountryURL = URL(string: "https://api.airvisual.com/v2/countries?key=2cc95ffe-2a84-4ce7-8cc4-5b5431bfaca2")


    func getCountries(completion: @escaping (Result<[String], NetworkError>) -> Void) {
        guard let baseURL =  getCountryURL else { return completion(.failure(.invalidURL))}
        
        print(baseURL)
        
        URLSession.shared.dataTask(with: baseURL) { data, response, error in
            
            if let er = error {
                print(er)
                return completion(.failure(.thrownError(er)))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                
                let countryData = try JSONDecoder().decode(Country.self, from: data)
                    let countryArray = countryData.data
                    var arrayToReturn: [String] = []
                
                    for country in countryArray {
                        let countryName = country.country
                        arrayToReturn.append(countryName)
                    }
                return completion(.success(arrayToReturn))
                
            } catch {
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
        
    }}
