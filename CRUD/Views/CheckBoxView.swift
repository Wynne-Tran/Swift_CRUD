//
//  CheckBoxView.swift
//  CRUD
//
//  Created by graphic on 2022-11-30.
//

import SwiftUI

struct CheckBoxView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    @ObservedObject var passedTaskItem: TaskItems
    var body: some View {
        Image(systemName: passedTaskItem.isCompleted() ? "checkmark.circle.fill" : "circle")
            .foregroundColor(passedTaskItem.isCompleted() ? .green : .secondary)
            .onTapGesture {
                if !passedTaskItem.isCompleted() {
                    passedTaskItem.completedDate = Date()
                    dateHolder.saveContext(viewContext)
                }
            }
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxView(passedTaskItem: TaskItems())
    }
}
