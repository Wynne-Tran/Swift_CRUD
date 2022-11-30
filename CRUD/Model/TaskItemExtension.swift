//
//  TaskItemExtension.swift
//  CRUD
//
//  Created by graphic on 2022-11-30.
//

import SwiftUI

extension TaskItems {
    func  isCompleted() -> Bool {
        return completedDate != nil
    }
    
    func  isOverDue() -> Bool {
        if let due = dueDate {
            return !isCompleted() && scheduleTime && due < Date()
        }
        return false
    }
    
    func overDueColor() -> Color {
        return isOverDue() ? .red : .black
    }
    
    func dueDateOnly() -> String {
        if let due = dueDate{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            return dateFormatter.string(from: due)
        }
        return ""
    }
}
