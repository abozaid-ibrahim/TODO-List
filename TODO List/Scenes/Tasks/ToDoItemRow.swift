//
//  TodoView.swift
//  TODO List
//
//  Created by abuzeid on 15.12.23.
//

import Foundation
import SwiftUI
import Combine

struct ToDoItemRow: View {
    @Binding var items: [ToDoItem]
    var item: ToDoItem
    var parentTitle: String? // Pass this from the parent view

    var onAddSubtask: (UUID) -> Void
    var onDelete: (UUID) -> Void

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: {
                    // Toggle the completion state of the item and its subtasks
                    toggleCompletion(for: item.id)
                }) {
                    Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "checkmark.circle")
                    Text(formattedTitle(for: item))
                    Spacer()
                }
                .padding(.leading, CGFloat(item.level * 5)) // Offset for hierarchy
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button("Add Subtask") {
                        onAddSubtask(item.id)
                    }
                    Button("Delete", role: .destructive) {
                        onDelete(item.id)
                    }
                }
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                Button("Add Subtask") {
                    onAddSubtask(item.id)
                }
                Button("Delete", role: .destructive) {
                    onDelete(item.id)
                }
            }
            // Display subtasks
            ForEach(item.subtasks ?? []) { subtask in
                ToDoItemRow(items: $items, item: subtask, onAddSubtask: onAddSubtask, onDelete: onDelete)
            }
        }
    }

  


    private func formattedTitle(for item: ToDoItem) -> String {
        if let parentId = item.parentId {
            return "\(items.first(where: { $0.id == parentId })?.title ?? "") Child \(item.id) - \(item.title)"
        } else {
            return "Root \(item.id) - \(item.title)"
        }
    }

    private func toggleCompletion(for itemId: UUID) {
//        if let index = items.firstIndex(where: { $0.id == itemId }) {
//            let isCompleted = items[index].isCompleted
//            items[index].isCompleted.toggle()
//            toggleCompletionForSubtasks(&items[index].subtasks, isCompleted: !isCompleted)
//        }
    }

    private func toggleCompletionForSubtasks(_ subtasks: inout [ToDoItem], isCompleted: Bool) {
//        for i in 0..<subtasks.count {
//            subtasks[i].isCompleted = isCompleted
//            if !subtasks[i].subtasks.isEmpty {
//                toggleCompletionForSubtasks(&subtasks[i].subtasks, isCompleted: isCompleted)
//            }
//        }
    }
}
