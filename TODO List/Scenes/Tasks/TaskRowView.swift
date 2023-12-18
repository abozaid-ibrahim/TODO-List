//
//  TaskRowView.swift
//  TODO: List
//
//  Created by abuzeid on 15.12.23.
//

import Combine
import Foundation
import SwiftUI

typealias TaskCompletionClosure = (TaskItem) -> Void

struct TaskRowView: View {
    var task: TaskItem
    var parentTitle: String?

    var onAddSubtask: TaskCompletionClosure
    var onDelete: TaskCompletionClosure
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
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
              
                HStack{
                    Button {
                        onAddSubtask(task)
                    } label: {
                        Label("Add Subtask", systemImage: "plus")
                    }
                    .tint(.green)
                    Button(role: .destructive) {
                        onDelete(task)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
    }
}
