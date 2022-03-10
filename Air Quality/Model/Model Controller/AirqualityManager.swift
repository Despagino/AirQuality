//
//  AirqualityManager.swift
//  Air Quality
//
//  Created by Gino Tasis on 3/9/22.
//

import Foundation


class AirqualityManager {
    
    // MARK: - String constants
    
    let baseURL = URL(string: "https://api.airvisual.com/v2/")
    let apiKey = "2cc95ffe-2a84-4ce7-8cc4-5b5431bfaca2"
    let apiKeyC = "key"
    
    
    let countriesC = "countries"
    let statesC = "states"
    let citiesC = "cities"
    let cityC = "city"
    
    let countryKey = "country"
    let stateKey = "state"
    let cityKey = "city"
    
    
    
    // MARK: - Get All Country API Call
     
        //https://api.airvisual.com/v2/countries?key={{YOUR_API_KEY}}

         func getCountries(completion: @escaping (Result<[String], NetworkError>) -> Void) {
            
             guard let baseURL =  baseURL else { return completion(.failure(.invalidURL)) }
             let countriesURL = baseURL.appendingPathComponent(countriesC)
             
             var components = URLComponents(url: countriesURL, resolvingAgainstBaseURL: true)
             let apiQuery = URLQueryItem(name: apiKeyC, value: apiKey)
             components?.queryItems = [apiQuery]
             
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
             
         }
     
    
        // MARK: - Get All States API CAll
        
            // endpoint: https://api.airvisual.com/v2/states?country={{COUNTRY_NAME}}&key={{YOUR_API_KEY}}

            func getStates(forCountry: String, completion: @escaping (Result<[String], NetworkError>) -> Void) {
                
                guard let baseURL =  baseURL else { return completion(.failure(.invalidURL)) }
                let stateURL = baseURL.appendingPathComponent(statesC)
                
                var components = URLComponents(url: stateURL, resolvingAgainstBaseURL: true)
                
                let countryQuery = URLQueryItem(name: countryKey, value: forCountry)
                let apiQuery = URLQueryItem(name: apiKeyC, value: apiKey)
                
                components?.queryItems = [countryQuery, apiQuery]
                
                guard let finalURL = components?.url else { return completion(.failure(.invalidURL))}
                
                print(finalURL)
                
                //URL Session
                
                URLSession.shared.dataTask(with: finalURL) { data, response, error in
                    
                    if let error = error {
                        print(error)
                        return completion(.failure(.thrownError(error)))
                    }
                    
                    guard let data = data else { return completion(.failure(.noData))}
                    do {
                        
                        let states = try JSONDecoder().decode(State.self, from: data)
                        let state = states.data
                        
                        var arrayToReturn: [String] = []
                        
                        for each in state {
                            let stateName = each.state
                            arrayToReturn.append(stateName)
                        }
                        return completion(.success(arrayToReturn))
                    }
                    catch {
                        completion(.failure(.thrownError(error)))
                    }
                }
            }
    }
