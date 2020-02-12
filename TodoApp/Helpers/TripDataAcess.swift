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

class TripDataAcess {
    
    static var context: NSManagedObjectContext? {
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return nil}
        return delegate.persistentContainer.viewContext
    }
    
   static func createTrip(name: String) -> Trip? {
        
        guard let context = context else {return nil}
        
        guard let entity = NSEntityDescription.entity(forEntityName: Trip.className, in: context) else {return nil}
        
        guard let  object = NSManagedObject(entity: entity, insertInto: context) as? Trip else {return nil}
        
        object.name = name
        object.created = Date()
        
      saveContext()
    
    return object
        

    }
    
   static func saveContext() {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return}
        delegate.saveContext()
    }
    
    static func fetchTrips() -> [Trip] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Trip.className)
        
        let sorting = NSSortDescriptor(key: "created", ascending: false)
        
        fetchRequest.sortDescriptors = [sorting]
        
        guard let context = context else {return []}
        
        do {
            guard let results = try context.fetch(fetchRequest) as? [Trip] else {
            return []
            }
            
            return results
        }   catch {
            print(error)
            return []
        }
        
    }
    
   static func removeTrip(trip: Trip) {
        
        context?.delete(trip)
        saveContext()
    }
    
    
    }

