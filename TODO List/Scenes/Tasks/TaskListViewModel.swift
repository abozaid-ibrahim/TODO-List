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
    @Published var tasks: [TaskItem] = []
    let taskManager = TaskCacheManager()
    
    func addTask(_ task: TaskItem, to parentId: UUID?) {
        if let parentId = parentId, let index = tasks.firstIndex(where: { $0.id == parentId }) {
            if tasks[index].subtasks == nil {
                tasks[index].subtasks = [task]
            } else {
                tasks[index].subtasks?.append(task)
            }
        } else {
            tasks.append(task)
        }
        Task{await cacheTask()}
    }
    
    func cacheTask() async {
        do {
            try await taskManager.cacheTasks(tasks)
        } catch {
            print("Error: \(error)")
        }
    }
    func fetchTasks() async {
        do {
            let tasks = try await taskManager.retrieveTasks()
            await MainActor.run{
                self.tasks = tasks
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func delete(task: TaskItem) {
        if let index = tasks.firstIndex(of: task) {
            tasks.remove(at: index)
        } else {
            for i in 0 ..< tasks.count {
                if let subIndex = tasks[i].subtasks?.firstIndex(of: task) {
                    tasks[i].removeSubtask(at: subIndex)
                    break
                }
            }
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        tasks.move(fromOffsets: source, toOffset: destination)
    }
    
    func toggleTaskCompletion(_ task: TaskItem) {
        if let index = tasks.firstIndex(of: task) {
            tasks[index].toggleCompletion()
        } else {
            for i in 0 ..< tasks.count {
                guard let subIndex = tasks[i].subtasks?.firstIndex(of: task) else { continue }
                tasks[i].subtasks?[subIndex].toggleCompletion()
                toggleParentCompletion(of: task, at: i)
                break
            }
        }
    }
    
    private func toggleParentCompletion(of _: TaskItem, at row: Int) {
        guard let subtasks = tasks[row].subtasks else { return }
        let isAllSubtasksCompleted = subtasks.allSatisfy { $0.isCompleted }
        if isAllSubtasksCompleted != tasks[row].isCompleted {
            tasks[row].toggleCompletion()
        }
    }
}
