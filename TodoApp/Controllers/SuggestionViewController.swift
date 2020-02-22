//
//  SuggestionViewController.swift
//  TodoApp
//
//  Created by Thomas Lenell on 2020-02-18.
//  Copyright © 2020 Thomas Lenell. All rights reserved.
//

import UIKit

class SuggestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    
    
    var trip: Trip?
 

    @IBOutlet weak var suggestView: UITableView!
    
    @IBAction func saveSuggestions(_ sender: UIBarButtonItem) {
        
        let selectedItems = suggestView.indexPathsForSelectedRows!
        
     //   guard let trip = trip else {return}
        
        for indexPath in selectedItems {
         let suggestions = sections[indexPath.section].suggestions[indexPath.row]
            _ = ItemDataAcess.createItem(name: suggestions, trip: trip!)
        }

        ItemDataAcess.saveContext()
        
        navigationController?.popViewController(animated: true)
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        suggestView.allowsMultipleSelection = true
        suggestView.delegate = self
        suggestView.dataSource = self as? UITableViewDataSource

    }
 
    var sections: [SuggestionSection] = {
            [
            SuggestionSection(title: "Clothes", suggestions: ["T-shirt", "Pants", "Shoes", "Swimwear", "Dress"]),
            SuggestionSection(title: "Electronics", suggestions: ["Charger", "Computer", "Travel speakers", "Adapters", "Headphones" ]),
            SuggestionSection(title: "Bathroom", suggestions: ["Toothbrush", "Schampoo & Soap", "Shaver", "Deodorant", "Hairbrush/Comb",    ]),
            SuggestionSection(title: "Good to have", suggestions: ["Sun Protection","Medical travel kit","Travel pillow"])
        ]
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
   
        
        return sections[section].suggestions.count

        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as? ItemCell else {
            return UITableViewCell()
            
        }
        
        var section: SuggestionSection

        section = sections[indexPath.section]

        cell.suggestions = sections[indexPath.section].suggestions[indexPath.row]
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let section = sections[section]

        
        guard let sectionHeader = Bundle.main.loadNibNamed(SectionHeader.className, owner: nil, options: nil)?.first as? SectionHeader else {return nil}
        
        
        sectionHeader.setTitle(title: section.title)
        
        
        return sectionHeader
    }

      func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
      }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // guard let cell = tableView.cellForRow(at: indexPath) else { return }

        suggestView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
        print("selected")
        
    }

func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    
       suggestView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
   print("deselected")
}


    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         if segue.identifier == self.suggestionToTrip {
//
//            guard let selectedItems = saveSuggestions(selectedItems) else {return}
//
//
//             let destinationVC = segue.destination as? TodoController
//
//            destinationVC?.incompletedItems =
//
//
//
//         }
//
//}
}
