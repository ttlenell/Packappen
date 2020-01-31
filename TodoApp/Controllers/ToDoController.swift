//
//  ToDoController.swift
//  TodoApp
//
//  Created by Thomas Lenell on 2020-01-25.
//  Copyright © 2020 Thomas Lenell. All rights reserved.
//

import UIKit

class TodoController: UITableViewController {
    
    var doStore: DoStore!
    {
        didSet {
            // get data
            doStore.doList = DoUtility.fetch() ?? [[Task](), [Task]()]

            // reload table view
            tableView.reloadData()


        }
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        doStore = DoStore()
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = UIColor.blue
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        
        // alert controller
        let alertController = UIAlertController(title: "Add packing item", message: nil, preferredStyle: .alert)
        
        // set up actions
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
        
            // grab text field text
            guard let name = alertController.textFields?.first?.text else {return}
            
            // create task
            let newTask = Task(name: name)
            
            // add task
            self.doStore.addTask(newTask, at: 0)
            // reload data in table view
            
            let indexPath = IndexPath(row: 0, section: 0)
            
            self.tableView.insertRows(at: [indexPath], with: .automatic)
            

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
    

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            
        return section == 0 ? "To be packed" : "Packed"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {

        
        return doStore.doList.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
        return doStore.doList[section].count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = doStore.doList[indexPath.section][indexPath.row].name
        
        return cell
            
    }
    

    

}
    
//MARK: - Delegate
    extension TodoController {
        
        override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            54
        }
        
        override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
            let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, sourceView, completionHandler) in
                
                // determine whether the task "isDone"
                guard let isDone =  self.doStore.doList[indexPath.section][indexPath.row].isDone
                    else {return}
                
                // remove task from correct array
                self.doStore.removeTask(at: indexPath.row, isDone: isDone)
                
                // reload table view
                tableView.deleteRows(at: [indexPath], with: .automatic)
                

                // indicate that the action was performed
                completionHandler(true)
            }
            
            deleteAction.image = #imageLiteral(resourceName: "delete")
            deleteAction.backgroundColor = #colorLiteral(red: 0.8862745098, green: 0.1450980392, blue: 0.168627451, alpha: 1)
            
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
        
        override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
            let doneAction = UIContextualAction(style: .normal, title: nil) { (action, sourceView, completionHandler) in
                
                // toggle that the task is done
                self.doStore.doList[0][indexPath.row].isDone = true
                
                // remove the task from the array todo
                let doneTask = self.doStore.removeTask(at: indexPath.row)
                
                // reload table view
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
                // add the task to the array done
                self.doStore.addTask(doneTask, at: 0, isDone: true)
                
                // reload table view
                tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
                

                // indicate the action was performed
                completionHandler(true)
            }
            
            doneAction.image = #imageLiteral(resourceName: "done")
            doneAction.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.7529411765, blue: 0.2901960784, alpha: 1)
            
            return indexPath.section == 0 ? UISwipeActionsConfiguration(actions: [doneAction]) : nil
        }
        
    }
    



