//
//  MainView.swift
//  TODO List
//
//  Created by abuzeid on 15.12.23.
//

import SwiftUI
struct MainView: View {
    @StateObject private var viewModel = ToDoListViewModel()
    @State private var showingEditScreen = false
    @State private var currentParentId: UUID?

    var body: some View {
        NavigationView {
            List {
                OutlineGroup(viewModel.items, children: \.subtasks) { item in
                    HStack {
                        Button(action: {
                            viewModel.toggleTaskCompletion(item)
                        }) {
                            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "checkmark.circle")
                        }
                        Text(item.title)
                    }
                }
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
}


#Preview {
    MainView()
}
