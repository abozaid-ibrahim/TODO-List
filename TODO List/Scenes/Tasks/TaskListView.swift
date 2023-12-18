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
    @State private var editMode = EditMode.inactive
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.tasks, id: \.self) { task in
                    TaskRowView(task: task,
                                onAddSubtask: edit(task:),
                                onDelete: viewModel.delete(task:),
                                onComplete: viewModel.toggleTaskCompletion(_:))
                    .onLongPressGesture {
                        withAnimation {
                            self.editMode = .active
                        }
                    }
                }
                
                .onMove{
                    viewModel.move(from:$0, to:$1)
                    withAnimation {
                        self.editMode = .inactive
                    }
                }
            }
            
            .environment(\.editMode, $editMode)
            .navigationBarTitle("ToDo List")
            .navigationBarItems(trailing: Button(action: {
                self.showingEditScreen = true
                self.currentParentId = nil
            }) {
                Image(systemName: "plus")
            })
            
            .sheet(isPresented: $showingEditScreen) {
                EditView(onSave: addNewTask(task:))
                    .presentationDetents([.medium])
            }
        }
        .task {
            await viewModel.fetchTasks()
        }
    }
    
    private func move(from source: IndexSet, to destination: Int) {
        viewModel.move(from: source, to: destination)
    }
    
    private func addNewTask(task: TaskItem) {
        viewModel.addTask(task, to: currentParentId)
        showingEditScreen = false
    }
    
    private func edit(task: TaskItem) {
        showingEditScreen = true
        currentParentId = task.id
    }
}

#Preview {
    TaskListView()
}
