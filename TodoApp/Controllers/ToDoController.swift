//
//  ToDoController.swift
//  TodoApp
//
//  Created by Thomas Lenell on 2020-01-25.
//  Copyright © 2020 Thomas Lenell. All rights reserved.
//

import UIKit

class TodoController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

  
    @IBOutlet weak var itemView: UITableView!
    
    var trip: Trip?
    var items = [Item]() {
        didSet {
            completedItems = items.filter { (item) -> Bool in
                return item.isDone
            
            }
            
            incompletedItems = items.filter { (item) -> Bool in
                       return !item.isDone
            }
        }
    }
    var completedItems = [Item]()
    
    var incompletedItems = [Item]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemView.delegate = self
        itemView.dataSource = self as? UITableViewDataSource
        
        // items = ItemDataAcess.fetchItems()
        
        items = trip?.items?.array as! [Item]
        
        self.title = trip?.name
        


        
        
        
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
  
    
    @IBAction func changeTripName(_ sender: UIButton) {
        

                   var trip: Trip
                trip = self.trip!
                   
                       // guard let trip = trip else {return}
                       
                       // alert controller
                       let alertController = UIAlertController(title: "Change trip name", message: nil, preferredStyle: .alert)
                       
                       // set up actions
                       let addAction = UIAlertAction(title: "Change", style: .default) { _ in
                           
                           
                       
                           // grab text field text
                           guard let name = alertController.textFields?.first?.text else {return}
                          
                           trip.name = name
                        self.title = name
                           TripDataAcess.saveContext()
                           
                           // save item to cre data
                        
                        
                           
                           print("ny titel")
                           
                       
                       }
                       
                       addAction.isEnabled = false
                       
                       let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                       
                       // add textfield for input to alert controller
                       alertController.addTextField { textfield in
                           
                           textfield.placeholder = "Change a trip's name"
                           textfield.addTarget(self, action: #selector(self.handleTextChanged), for: .editingChanged)
                       }
                       // add actions to alert controller
                       alertController.addAction(addAction)
                       alertController.addAction(cancelAction)
                       
                       
                       // present alert controller
                       
                       present(alertController, animated: true)

        
    }
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        
        
        
        guard let trip = trip else {return}
        
        // alert controller
        let alertController = UIAlertController(title: "Add packing item", message: nil, preferredStyle: .alert)
        
        // set up actions
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
        
            // grab text field text
            guard let name = alertController.textFields?.first?.text else {return}
            

            // create item in coredata
            guard let item = ItemDataAcess.createItem(name: name, trip: trip) else {return}
        
            // add item to tableview
            self.incompletedItems.insert(item, at: 0)
            
            let indexPath = IndexPath(row: 0, section: 0)
            
            self.itemView.insertRows(at: [indexPath], with: .automatic)
            

        }
        
        addAction.isEnabled = false
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // add textfield for input to alert controller
        alertController.addTextField { textfield in
            
            textfield.placeholder = "Enter a packing item"
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
}



// MARK: - DataSource
extension TodoController {
    
    // sets height for sections 0 and 1, "to be packed" and "packed"
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          return 58
    }
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionHeader = Bundle.main.loadNibNamed(SectionHeader.className, owner: nil, options: nil)?.first as? SectionHeader else {return nil}
        if section == 0 {
            sectionHeader.setTitle(title: "To be packed")
        } else {
            sectionHeader.setTitle(title: "Packed")
        }
        return sectionHeader
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // will always just be two sections
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
        if section == 0 {
            return incompletedItems.count
            
        } else {
            return completedItems.count
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as? ItemCell else {
            return UITableViewCell()
            
        }
        var item: Item
        if indexPath.section == 0 {
            item = self.incompletedItems[indexPath.row]
            
        } else {
            item = self.completedItems[indexPath.row]
           
            
        }
        cell.item = item
        return cell
            
    }
    

    

}
    
//MARK: - Delegate
    extension TodoController {
        

        
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
            let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, sourceView, completionHandler) in
                
               
                
                // remove task from correct array
                var item: Item
                if indexPath.section == 0 {
                    item = self.incompletedItems.remove(at: indexPath.row)
                    
                } else {
                    item = self.completedItems.remove(at: indexPath.row)
                }
                
                ItemDataAcess.removeItem(item: item)
                
                // reload table view
                
                tableView.deleteRows(at: [indexPath], with: .automatic)

                // indicate that the action was performed
                
                completionHandler(true)
            }
            
            deleteAction.image = #imageLiteral(resourceName: "delete")
            deleteAction.backgroundColor = #colorLiteral(red: 0.8862745098, green: 0.1450980392, blue: 0.168627451, alpha: 1)
            
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            if indexPath.section == 0 {
                
            
            
 
            var item: Item
            item = self.incompletedItems[indexPath.row]
            
                // guard let trip = trip else {return}
                
                // alert controller
                let alertController = UIAlertController(title: "Change item name", message: nil, preferredStyle: .alert)
                
                // set up actions
                let addAction = UIAlertAction(title: "Change", style: .default) { _ in
                    
                    
                
                    // grab text field text
                    guard let name = alertController.textFields?.first?.text else {return}
                   
                    item.name = name
                    ItemDataAcess.saveContext()
                    
                    // save item to cre data
                    
                    tableView.reloadData()
 
                }
                
                addAction.isEnabled = false
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
                // add textfield for input to alert controller
                alertController.addTextField { textfield in
                    
                    textfield.placeholder = "Change a item name"
                    textfield.addTarget(self, action: #selector(self.handleTextChanged), for: .editingChanged)
                }
                // add actions to alert controller
                alertController.addAction(addAction)
                alertController.addAction(cancelAction)
                
                
                // present alert controller
                
                present(alertController, animated: true)
                
            
            }
        }
        
        func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
            if indexPath.section == 1 {
                return nil
            }
            
            
            let doneAction = UIContextualAction(style: .normal, title: nil) { (action, sourceView, completionHandler) in
                
                // toggle that the task is done
                
                
                ItemDataAcess.setItemDone(item: self.incompletedItems[indexPath.row])
                
            
                // removes item from the array todo
               let item = self.incompletedItems.remove(at: indexPath.row)
                
                // removes item from table view
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
                // add the task to the array completedItems
                self.completedItems.insert(item, at: 0)
                
                // reload table view
                tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
                

                
                // indicate the action was performed
                completionHandler(true)
            }
            
            doneAction.image = #imageLiteral(resourceName: "done")
            doneAction.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.7529411765, blue: 0.2901960784, alpha: 1)
            
            return UISwipeActionsConfiguration(actions: [doneAction])
        }
        
   
        
    }
    



