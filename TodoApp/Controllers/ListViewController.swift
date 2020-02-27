//
//  ListViewController.swift
//  TodoApp
//
//  Created by Thomas Lenell on 2020-02-05.
//  Copyright © 2020 Thomas Lenell. All rights reserved.
//

import UIKit

class ListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    
    var trips = [Trip]()
    var selectedTrip: IndexPath?
    let tripToItem = "TripToItem"
    
    
    
      
    
    @IBOutlet weak var listView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trips = TripDataAcess.fetchTrips()
        self.title = "PackApp"
        
        overrideUserInterfaceStyle = .light
        
        listView.delegate = self
        listView.dataSource = self as? UITableViewDataSource
        
        
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = UIColor(named: "Blue")
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        listView.reloadData()
        
    }
    
    @IBAction func addTrip(_ sender: UIBarButtonItem) {
        
        
        
        // alert controller
        let alertController = UIAlertController(title: "Add new trip", message: nil, preferredStyle: .alert)
        
        // set up actions
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            
            // grab text field text
            guard let name = alertController.textFields?.first?.text else {return}
            
            
            // create item in core data
            guard let trip = TripDataAcess.createTrip(name: name) else {return}
            
            // add item to table view
            self.trips.insert(trip, at: 0)
            
            let indexPath = IndexPath(row: 0, section: 0)
            
            self.listView.insertRows(at: [indexPath], with: .automatic)
            
            
        }
        
        addAction.isEnabled = false
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // add textfield for input to alert controller
        alertController.addTextField { textfield in
            
            textfield.placeholder = "Enter a new trip"
            textfield.addTarget(self, action: #selector(self.handleTextChanged), for: .editingChanged)
        }
        // add actions to alert controller
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        
        // present alert controller
        
        present(alertController, animated: true)
        
    }
    
    @objc private func handleTextChanged(_ sender: UITextField) {
        
        // grab alert controller and add action
        
        guard let alertController = presentedViewController as? UIAlertController,
            let addAction = alertController.actions.first,
            let text = sender.text
            else {return}
        
        // Enable add action based on if text is empty or contains whitespace
        
        addAction.isEnabled = !text.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let sectionHeader = Bundle.main.loadNibNamed(SectionHeader.className, owner: nil, options: nil)?.first as? SectionHeader else {return nil}
        
        sectionHeader.setTitle(title: "My trips")
        
        return sectionHeader
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            
        }
        return trips.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selectedTrip = indexPath
        performSegue(withIdentifier: tripToItem, sender: self)
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DataCell else {
            return UITableViewCell()
            
        }
        
        var trip: Trip
        
        trip = self.trips[indexPath.row]
        
        
        cell.trip = trip
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, sourceView, completionHandler) in
            
            var trip: Trip
  
            trip = self.trips.remove(at: indexPath.row)
            

            TripDataAcess.removeTrip(trip: trip)
   
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            // indicate that the action was performed
            
            completionHandler(true)
        }
        
        deleteAction.image = #imageLiteral(resourceName: "delete")
        deleteAction.backgroundColor = #colorLiteral(red: 0.8862745098, green: 0.1450980392, blue: 0.168627451, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.tripToItem {
            
            guard let selectedTrip = self.selectedTrip else {return}
            
    
            let destinationVC = segue.destination as? TodoController
            
            destinationVC?.trip = trips[selectedTrip.row]

           
            
        }
    }
    
}








