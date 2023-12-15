//
//  TodoItem.swift
//  TODO List
//
//  Created by abuzeid on 15.12.23.
//

import Foundation

struct ToDoItem: Identifiable, Equatable, Hashable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    var level: Int = 0 // Used for indentation level and could be used to infer hierarchy.
    var parentId: UUID? // Optional, as root tasks won't have a parentId.
    var subtasks: [ToDoItem]?
  
    static func == (lhs: ToDoItem, rhs: ToDoItem) -> Bool {
        return lhs.id == rhs.id
    }
}
class ToDoListViewModel: ObservableObject {
    @Published var items: [ToDoItem] = []
    
    func addTask(_ task: ToDoItem, to parentId: UUID?) {
        if let parentId = parentId, let index = items.firstIndex(where: { $0.id == parentId }) {
            items[index].subtasks?.append(task)
        } else {
            items.append(task)
        }
    }
    
    func deleteTask(withId id: UUID) {
        if let index = items.firstIndex(where: { $0.id == id }) {
            items.remove(at: index)
        } else {
            for i in 0..<items.count {
                if let subIndex = items[i].subtasks?.firstIndex(where: { $0.id == id }) {
                    items[i].subtasks?.remove(at: subIndex)
                    break
                }
            }
        }
    }
    
    func toggleTaskCompletion(_ task: ToDoItem) {
//        if let index = items.firstIndex(of: task) {
//            items[index].isCompleted.toggle()
//            toggleSubtasksCompletion(&items[index].subtasks, to: items[index].isCompleted)
//        }
    }
    
    private func toggleSubtasksCompletion(_ subtasks: inout [ToDoItem], to isCompleted: Bool) {
//        for i in 0..<subtasks.count {
//            subtasks[i].isCompleted = isCompleted
//            toggleSubtasksCompletion(&subtasks[i].subtasks, to: isCompleted)
//        }
    }
}
