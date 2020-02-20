//
//  SuggestionViewController.swift
//  TodoApp
//
//  Created by Thomas Lenell on 2020-02-18.
//  Copyright © 2020 Thomas Lenell. All rights reserved.
//

import UIKit

class SuggestionViewController: UIViewController, UITableViewDataSource
{

     var suggestedItems = [SuggestionSection]()
    

    override func viewDidLoad() {
        super.viewDidLoad()



        
    }
 
  let sections: [SuggestionSection] = {
            [
            SuggestionSection(title: "Clothes", suggestions: ["T-shirt", "Pants", "Shoes"]),
            SuggestionSection(title: "Electronics", suggestions: ["Charger", "Computer"]),
            SuggestionSection(title: "Bathroom", suggestions: ["Toothbrush"]),
            SuggestionSection(title: "Blabla", suggestions: ["some blabla"])
        ]
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as? ItemCell else {
            return UITableViewCell()
            
        }

// var section =  sections[indexPath.section]
       
        return cell
    }
    

      func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
      }
    


}
