//
//  CountiriesTableViewController.swift
//  Air Quality
//
//  Created by Gino Tasis on 3/9/22.
//

import UIKit

class CountriesTableViewController: UITableViewController {
    
    // MARK: - Properties
    var countries: [String] = []
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCountries()
    }
    
    
    // MARK: - Helper Methods
    
    
    func getCountries() {
        AirqualityManager.getCountries { result in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let countries):
                    self.countries = countries
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return countries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        
        let country = countries[indexPath.row]
        
        cell.textLabel?.text = country
        
        return cell
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToState" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? StatesTableViewController
            else {
                return
            }
            let country = countries[indexPath.row]
            destination.country = country
        }
    }
}
