//
//  DoUtility.swift
//  TodoApp
//
//  Created by Thomas Lenell on 2020-01-28.
//  Copyright © 2020 Thomas Lenell. All rights reserved.
//

import Foundation

//  class DoUtility {
//
//    private static let key = "tasks"
//
//    // archive
//    private static func archive(_ tasks: [[Task]]) -> Data {
//        return try! NSKeyedArchiver.archivedData(withRootObject: tasks, requiringSecureCoding: false)
//    }
//
//    // fetch
//    static func fetch() -> [[Task]]? {
//        guard let unArchivedData = UserDefaults.standard.object(forKey: key) as? Data else { return nil}
//
//        return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(unArchivedData) as? [[Task]] ?? [[]]
//    }
//
//    // save
//
//    static func save(_ tasks: [[Task]]) {
//
//        // Archive datad
//        let archivedTasks = archive(tasks)
//
//        // set objects for key
//        UserDefaults.standard.set(archivedTasks, forKey: key)
//        UserDefaults.standard.synchronize()
//
//    }
//
//}
