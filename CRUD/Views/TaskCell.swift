//
//  TaskCell.swift
//  CRUD
//
//  Created by graphic on 2022-11-30.
//

import SwiftUI

struct TaskCell: View {
    @EnvironmentObject var dateHolder: DateHolder
    @ObservedObject var passedTaskItem: TaskItems
    
    var body: some View {
        CheckBoxView(passedTaskItem: passedTaskItem).environmentObject(dateHolder)
        Text(passedTaskItem.name ?? "")
            .padding(.horizontal)
        if !passedTaskItem.isCompleted() && passedTaskItem.scheduleTime {
            Spacer()
            Text(passedTaskItem.dueDateOnly())
                .font(.footnote)
                .foregroundColor(passedTaskItem.overDueColor())
                .padding(.horizontal)
        }
            
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(passedTaskItem: TaskItems())
    }
}
