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
    var onSave: (ToDoItem) -> Void
    @State private var title: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
            }
            .navigationBarTitle("Add Task")
            .navigationBarItems(trailing: Button("Save") {
                let newTask = ToDoItem(id: UUID(), title: title, isCompleted: false, level: 0, subtasks: [])
                onSave(newTask)
                presentationMode.wrappedValue.dismiss()
            }.disabled(title.isEmpty))
        }
    }
}
