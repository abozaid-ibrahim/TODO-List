//
//  TodoItem.swift
//  TODO List
//
//  Created by abuzeid on 15.12.23.
//

import Foundation
struct ToDoItem: Identifiable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    var subtasks: [ToDoItem]
}
