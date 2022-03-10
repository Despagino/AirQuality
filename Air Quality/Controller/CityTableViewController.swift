//
//  CityTableViewController.swift
//  Air Quality
//
//  Created by Gino Tasis on 3/9/22.
//

import UIKit

class CityTableViewController: UITableViewController {
    
    // MARK: - Properties
    var country: String?
    var state: String?
    var cities: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        getCities()
    }

    // MARK: - Helper functions
    
    func getCities() {
        guard let state = state, let country = country else { return }
        AirqualityManager.getCity(forState: state , inCountry: country ) { result in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let cities):
                    self.cities = cities
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        let city = cities[indexPath.row]
        cell.textLabel?.text = city

        return cell
    }
    

    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    

}
