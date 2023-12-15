//
//  EditView.swift
//  TODO: List
//
//  Created by abuzeid on 15.12.23.
//

import Combine
import Foundation
import SwiftUI

struct EditView: View {
    var onSave: TaskCompletionClosure
    @State private var title: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
            }
            .navigationBarTitle("Add Task")
            .navigationBarItems(trailing: Button("Save") {
                onSave(TaskItem(title: title))
                presentationMode.wrappedValue.dismiss()
            }.disabled(title.isEmpty))
        }
    }
}
