//
//  AirqualityManager.swift
//  Air Quality
//
//  Created by Gino Tasis on 3/9/22.
//

import Foundation


class AirqualityManager {
    
    // MARK: - String constants
    
    static let baseURL = URL(string: "https://api.airvisual.com/v2/")
    static let apiKey = "2cc95ffe-2a84-4ce7-8cc4-5b5431bfaca2"
    static let apiKeyC = "key"
    
    
    static let countriesC = "countries"
    static let statesC = "states"
    static let citiesC = "cities"
    static let cityC = "city"
    
    static let countryKey = "country"
    static let stateKey = "state"
    static let cityKey = "city"
    
    
    // MARK: - Get All Country API Call
     
        //https://api.airvisual.com/v2/countries?key={{YOUR_API_KEY}}

         static func getCountries(completion: @escaping (Result<[String], NetworkError>) -> Void) {
            
             guard let baseURL =  baseURL else { return completion(.failure(.invalidURL)) }
             let countriesURL = baseURL.appendingPathComponent(countriesC)

             var components = URLComponents(url: countriesURL, resolvingAgainstBaseURL: true)
             let apiQuery = URLQueryItem(name: apiKeyC, value: apiKey)
             components?.queryItems = [apiQuery]
             
             guard let finalURL = components?.url else {return completion(.failure(.invalidURL))}
             
             URLSession.shared.dataTask(with: finalURL) { data, response, error in

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
     
//
//        // MARK: - Get All States API CAll
//
//            // endpoint: https://api.airvisual.com/v2/states?country={{COUNTRY_NAME}}&key={{YOUR_API_KEY}}
//
//            static func getStates(forCountry: String, completion: @escaping (Result<[String], NetworkError>) -> Void) {
//
//                guard let baseURL =  baseURL else { return completion(.failure(.invalidURL)) }
//                let stateURL = baseURL.appendingPathComponent(statesC)
//
//                var components = URLComponents(url: stateURL, resolvingAgainstBaseURL: true)
//
//                let countryQuery = URLQueryItem(name: countryKey, value: forCountry)
//                let apiQuery = URLQueryItem(name: apiKeyC, value: apiKey)
//
//                components?.queryItems = [countryQuery, apiQuery]
//
//                guard let finalURL = components?.url else { return completion(.failure(.invalidURL))}
//
//                print(finalURL)
//
//                //URL Session
//
//                URLSession.shared.dataTask(with: finalURL) { data, response, error in
//
//                    if let error = error {
//                        print(error)
//                        return completion(.failure(.thrownError(error)))
//                    }
//
//                    guard let data = data else { return completion(.failure(.noData))}
//                    do {
//
//                        let states = try JSONDecoder().decode(State.self, from: data)
//                        let state = states.data
//
//                        var arrayToReturn: [String] = []
//
//                        for each in state {
//                            let stateName = each.state
//                            arrayToReturn.append(stateName)
//                        }
//                        return completion(.success(arrayToReturn))
//                    }
//                    catch {
//                        completion(.failure(.thrownError(error)))
//                    }
//                }
//            }
//
//
//
//        // MARK: - getting City of Each State
//
//
//        //endpoint: http://api.airvisual.com/v2/cities?state={{STATE_NAME}}&country={{COUNTRY_NAME}}&key={{YOUR_API_KEY}}
//
//
//        static func getCity(forState: String, inCountry: String, completion: @escaping (Result<[String], NetworkError>) -> Void) {
//
//            guard let baseURL = baseURL else {
//                return completion(.failure(.invalidURL))
//            }
//
//            let citiesURL = baseURL.appendingPathComponent(citiesC)
//
//            var components = URLComponents(url: citiesURL, resolvingAgainstBaseURL: true)
//
//            let stateQuery = URLQueryItem(name: stateKey, value: forState)
//            let countryQuery = URLQueryItem(name: countryKey, value: inCountry)
//            let apiKeyQuery = URLQueryItem(name: apiKeyC, value: apiKey)
//
//            components?.queryItems = [stateQuery, countryQuery, apiKeyQuery]
//
//            guard let finalURL = components?.url else { return completion(.failure(.invalidURL))}
//            print(finalURL)
//
//            // URL Session
//            URLSession.shared.dataTask(with: finalURL) { data, response, error in
//
//                if let error = error {
//                    return completion(.failure(.thrownError(error)))
//                }
//
//                do {
//
//                    guard let data = data else { return completion(.failure(.noData))}
//
//                    do {
//                        let citiesArray = try JSONDecoder().decode(City.self, from: data)
//                        let cities = citiesArray.data
//
//                        var arrayToReturn: [String] = []
//
//                        for city in cities {
//                            let cityName = city.city
//                            arrayToReturn.append(cityName)
//                        }
//                        return completion(.success(arrayToReturn))
//                    }
//                    catch {
//                        return completion(.failure(.thrownError(error)))
//                    }
//
//                }
//            }
//        }
//
//
//
//    // MARK: - Getting City Info
//
//    //endpoint: https://api.airvisual.com/v2/city?city=Los Angeles&state=California&country=USA&key={{YOUR_API_KEY}}
//
//
//    static func getCityInfo(forCity: String, forState: String, forCountry: String, completion: @escaping (Result<EachCityInfo, NetworkError>) -> Void) {
//
//        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
//
//        let cityURL = baseURL.appendingPathComponent(cityKey)
//
//        var components = URLComponents(url: cityURL, resolvingAgainstBaseURL: true)
//
//        let cityQuery = URLQueryItem(name: cityKey, value: forCity)
//        let stateQuery = URLQueryItem(name: stateKey, value: forState)
//        let countryQuery = URLQueryItem(name: countryKey, value: forCountry)
//        let apiQuery = URLQueryItem(name: apiKeyC, value: apiKey)
//        components?.queryItems = [cityQuery, stateQuery, countryQuery, apiQuery]
//
//        guard let finalURL = components?.url else { return completion(.failure(.invalidURL))}
//        print(finalURL)
//
//
//        //URL Session
//
//        URLSession.shared.dataTask(with: finalURL) { data, response, error in
//
//            if let error = error {
//                return completion(.failure(.thrownError(error)))
//            }
//
//            guard let data = data else { return completion(.failure(.noData))}
//
//            do {
//                let cityData = try JSONDecoder().decode(EachCityInfo.self, from: data)
//                return completion(.success(cityData))
//            }
//            catch {
//                return completion(.failure(.thrownError(error)))
//            }
//        }
//    }
    
    }
