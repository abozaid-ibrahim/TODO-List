//
//  TaskCacheManager.swift
//  TODO List
//
//  Created by abuzeid on 18.12.23.
//

import Foundation
import Combine

//class TaskCacheManager {
//    static let shared = TaskCacheManager()
//    private let fileURL: URL
//
//    private init() {
//        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        fileURL = documentsDirectory.appendingPathComponent("TaskItems.json")
//    }
//
//  
//    func cacheTasks(_ tasks: [TaskItem]) {
//        
//        do {
//            let data = try JSONEncoder().encode(tasks)
//            try data.write(to: fileURL, options: [.atomicWrite])
//        } catch {
//            print("Error saving tasks: \(error)")
//        }
//    }
//
//    func retrieveTasks() -> [TaskItem]? {
//        do {
//            let data = try Data(contentsOf: fileURL)
//            return try JSONDecoder().decode([TaskItem].self, from: data)
//        } catch {
//            print("Error loading tasks: \(error)")
//            return nil
//        }
//    }
//}
import Foundation

actor TaskCacheManager {
    private let fileURL: URL

    init() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        fileURL = documentsDirectory.appendingPathComponent("TaskItems.json")
    }

    func cacheTasks(_ tasks: [TaskItem]) async throws {
        do {
            let data = try JSONEncoder().encode(tasks)
            try data.write(to: fileURL, options: [.atomicWrite])
        } catch {
            throw error
        }
    }

    func retrieveTasks() async throws -> [TaskItem] {
        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode([TaskItem].self, from: data)
        } catch {
            throw error
        }
    }
}
