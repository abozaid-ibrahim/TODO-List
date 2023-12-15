//
//  EditView.swift
//  TODO List
//
//  Created by abuzeid on 15.12.23.
//

import Foundation
import SwiftUI
import Combine


struct EditView: View {
    @Binding var parentId: UUID?
    var item: ToDoItem?
    var onSave: (ToDoItem) -> Void
    @State private var title: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
            }
            .navigationBarTitle(item == nil ? "Add Task" : "Edit Task")
            .navigationBarItems(trailing: Button("Save") {
                let newTask = ToDoItem(id: UUID(), title: title, isCompleted: false, subtasks: [])
                onSave(newTask)
                presentationMode.wrappedValue.dismiss()
            }.disabled(title.isEmpty || title == item?.title))
        }
        .onAppear {
            if let item = item {
                title = item.title
            }
        }
    }
}
