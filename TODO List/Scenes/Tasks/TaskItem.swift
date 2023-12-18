//
//  Task.swift
//  TODO: List
//
//  Created by abuzeid on 15.12.23.
//

import Foundation

struct TaskItem: Identifiable, Equatable, Hashable, Codable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    let parentId: UUID? // Optional, as root tasks won't have a parentId.
    var subtasks: [TaskItem]?
    init(id: UUID = UUID(), title: String, isCompleted: Bool = false, parentId: UUID? = nil, subtasks: [TaskItem]? = nil) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.parentId = parentId
        self.subtasks = subtasks
    }

    static func == (lhs: TaskItem, rhs: TaskItem) -> Bool {
        return lhs.id == rhs.id
    }

    mutating func addSubtask(title: String) {
        let newSubtask = TaskItem(title: title)
        subtasks?.append(newSubtask)
    }

    mutating func removeSubtask(at index: Int) {
        subtasks?.remove(at: index)
    }

    mutating func toggleCompletion() {
        isCompleted.toggle()
        guard let indices = subtasks?.indices else { return }
        for index in indices {
            subtasks?[index].toggleCompletion()
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
