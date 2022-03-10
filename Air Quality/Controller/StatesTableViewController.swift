//
//  StatesTableViewController.swift
//  Air Quality
//
//  Created by Gino Tasis on 3/9/22.
//

import UIKit

class StatesTableViewController: UITableViewController {

    // MARK: - Properties
    
    var country: String?
    var states: [String] = []

    // MARK: - lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getStates()
        
    }
    
    // MARK: - Helper methods
    
    func getStates() {
        guard let country = country else { return }
        AirqualityManager.getStates(forCountry: country) { result in
            DispatchQueue.main.async {
                
                switch result {
                    
                case .success(let states):
                    self.states = states
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Error: \(error)")
                }
                
            }
        }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return states.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath)
        let state = states[indexPath.row]
        cell.textLabel?.text = state
    
        return cell
    }
    
    // MARK: - Navigation

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToCity" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? CityTableViewController
            else {
                return
            }
            let state = states[indexPath.row]
            destination.state = state
            destination.country = country
        }
        
    }
   

}
