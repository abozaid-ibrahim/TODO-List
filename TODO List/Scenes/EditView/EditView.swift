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
    private var onSave: TaskCompletionClosure
    @State private var title: String = ""
    @Environment(\.presentationMode)
    private var presentationMode
    init(onSave: @escaping TaskCompletionClosure) {
        self.onSave = onSave
    }

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
