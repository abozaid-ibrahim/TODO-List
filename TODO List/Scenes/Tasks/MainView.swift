//
//  MainView.swift
//  TODO List
//
//  Created by abuzeid on 15.12.23.
//

import SwiftUI

struct MainView: View {
    @State private var items: [ToDoItem] = []
    @State private var showingEditScreen = false
    @State private var parentTaskId: UUID?

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    ToDoItemRow(item: item, onAddSubtask: { parentId in
                        self.parentTaskId = parentId
                        self.showingEditScreen = true
                    })
                }
                .onDelete(perform: delete)
            }
            .navigationBarTitle("ToDo List")
            .navigationBarItems(trailing: Button(action: {
                self.showingEditScreen = true
            }) {
                Image(systemName: "plus")
            })
        }
        .sheet(isPresented: $showingEditScreen) {
            EditView(parentId: $parentTaskId, onSave: { newItem in
                if let parentId = parentTaskId {
                    if let index = items.firstIndex(where: { $0.id == parentId }) {
                        items[index].subtasks.append(newItem)
                    }
                } else {
                    self.items.append(newItem)
                }
                self.showingEditScreen = false
                self.parentTaskId = nil
            })
        }
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}

struct ToDoItemRow: View {
    var item: ToDoItem
    var onAddSubtask: (UUID) -> Void

    var body: some View {
        HStack {
            Button(action: {
                // Toggle the completion state
            }) {
                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "checkmark.circle")
            }
            Text(item.title)
            Spacer()
            if !item.subtasks.isEmpty {
                Image(systemName: "chevron.right")
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button("Add Subtask") {
                onAddSubtask(item.id)
            }
            Button("Delete", role: .destructive) {
                // Handle delete action
            }
        }
        .swipeActions(edge: .leading) {
            Button("Toggle") {
                // Handle toggle completion action
            }
        }
        ForEach(item.subtasks) { subtask in
            ToDoItemRow(item: subtask, onAddSubtask: { _ in })
                .padding(.leading)
        }
    }
}


#Preview {
    MainView()
}
