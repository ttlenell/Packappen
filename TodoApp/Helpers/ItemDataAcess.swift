//
//  ItemDataAcess.swift
//  TodoApp
//
//  Created by Thomas Lenell on 2020-02-04.
//  Copyright © 2020 Thomas Lenell. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ItemDataAcess {
    
    static var context: NSManagedObjectContext? {
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return nil}
        return delegate.persistentContainer.viewContext
    }
    
    static func createItem(name: String, trip: Trip) -> Item? {
        
        guard let context = context else {return nil}
        
        guard let entity = NSEntityDescription.entity(forEntityName: Item.className, in: context) else {return nil}
        
        guard let  object = NSManagedObject(entity: entity, insertInto: context) as? Item else {return nil}
    
        
        object.trip = trip
        object.name = name
        object.isDone = false
        object.created = Date()
        
      saveContext()
    
    return object
        

    }
    
   static func saveContext() {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return}
        delegate.saveContext()
    }
    
    static func fetchItems() -> [Item] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Item.className)
        
        let sorting = NSSortDescriptor(key: "created", ascending: false)
        
        fetchRequest.sortDescriptors = [sorting]
        
        guard let context = context else {return []}
        
        do {
            guard let results = try context.fetch(fetchRequest) as? [Item] else {
            return []
            }
            
            return results
        }   catch {print(error)
            return []
        }
        
    }
    
   static func removeItem(item: Item) {
        
        context?.delete(item)
        saveContext()
    }
    
    
    static func setItemDone(item: Item) {
        item.isDone = true
        saveContext()
        
    }
    
    
    }

