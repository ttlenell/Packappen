//
//  DoStore.swift
//  TodoApp
//
//  Created by Thomas Lenell on 2020-01-25.
//  Copyright © 2020 Thomas Lenell. All rights reserved.
//

//import Foundation
//
//
//class DoStore {
//
//    var doList = [[Task](), [Task]()] // göra om till en array istället för två?
//
//    // add items
//
//    func addTask(_ task:Task, at index: Int, isDone: Bool = false) {
//
//        let section = isDone ? 1 : 0
//
//        doList[section].insert(task, at: index)
//
//    }
//
//     // remove tasks
//
//        @discardableResult func removeTask(at index: Int, isDone: Bool = false) -> Task {
//
//
//            let section = isDone ? 1 : 0
//
//           return doList[section].remove(at: index)
//    }
//}
