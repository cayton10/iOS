//
//  ToDoModel.swift
//  ToDoList
//
//  Created by Benjamin Paul Cayton on 10/7/20.
//

import Foundation


//ToDo Struct

struct ToDo {
    var title: String
    var isComplete: Bool
    var dueDate: Date
    //Optional string. Not all list items will have a description
    var notes: String?
    //Static function to load array of todo items
    static func loadToDos() -> [ToDo]? {
        return nil
    }
    
    //Static function to load sample data
    static func loadSampleToDos() -> [ToDo]? {
        let todo1 = ToDo(title: "ToDo One", isComplete: false, dueDate: Date(), notes: "Notes 1")
        let todo2 = ToDo(title: "ToDo Two", isComplete: false, dueDate: Date(), notes: "Notes 2")
        let todo3 = ToDo(title: "ToDo Three", isComplete: false, dueDate: Date(), notes: "Notes 3")
        
        return [todo1, todo2, todo3]

    }
    
}
