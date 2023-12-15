//
//  MainView.swift
//  TODO: List
//
//  Created by abuzeid on 15.12.23.
//

import SwiftUI

struct TaskListView: View {
    @StateObject private var viewModel = TaskListViewModel()
    @State private var showingEditScreen = false
    @State private var currentParentId: UUID?

    var body: some View {
        NavigationView {
            List(viewModel.items, id: \.self) { task in
                TaskRowView(task: task,
                            onAddSubtask: edit(taskId:),
                            onDelete: viewModel.deleteTask(withId:),
                            onComplete: viewModel.toggleTaskCompletion(_:))
            }
            .navigationBarTitle("ToDo List")
            .navigationBarItems(trailing: Button(action: {
                self.showingEditScreen = true
                self.currentParentId = nil
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingEditScreen) {
                EditView(onSave: { newTask in
                    viewModel.addTask(newTask, to: currentParentId)
                    showingEditScreen = false
                })
            }
        }
    }

    private func edit(taskId: UUID) {
        showingEditScreen = true
        currentParentId = taskId
    }
}

#Preview {
    TaskListView()
}
