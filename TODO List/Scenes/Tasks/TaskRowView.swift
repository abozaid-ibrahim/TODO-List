//
//  TaskRowView.swift
//  TODO: List
//
//  Created by abuzeid on 15.12.23.
//

import Combine
import Foundation
import SwiftUI

typealias TaskIDCompletionClosure = (UUID) -> Void
typealias TaskCompletionClosure = (TaskItem) -> Void

struct TaskRowView: View {
    var task: TaskItem
    var parentTitle: String?

    var onAddSubtask: TaskIDCompletionClosure
    var onDelete: TaskIDCompletionClosure
    var onComplete: TaskCompletionClosure

    var body: some View {
        OutlineGroup(task, children: \.subtasks) { item in
            HStack {
                Button(action: {
                    onComplete(item)
                }) {
                    Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "checkmark.circle")
                }
                Text(item.title)
            }
            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                Button {
                    onAddSubtask(task.id)
                } label: {
                    Label("Add Subtask", systemImage: "plus")
                }
                .tint(.green)
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button(role: .destructive) {
                    onDelete(task.id)
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
    }
}
