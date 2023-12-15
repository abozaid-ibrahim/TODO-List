//
//  TaskViewModel.swift
//  TODO: List
//
//  Created by abuzeid on 15.12.23.
//

import Foundation
import SwiftUI
import TODO

final class TaskListViewModel: ObservableObject {
    @Published var items: [TaskItem] = []

    func addTask(_ task: TaskItem, to parentId: UUID?) {
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
            for i in 0 ..< items.count {
                if let subIndex = items[i].subtasks?.firstIndex(where: { $0.id == id }) {
                    items[i].subtasks?.remove(at: subIndex)
                    break
                }
            }
        }
    }

    func toggleTaskCompletion(_ task: TaskItem) {
        guard let index = items.firstIndex(of: task) else { return }
        items[index].toggleCompletion()
    }
}
