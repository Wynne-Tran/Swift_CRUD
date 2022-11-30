//
//  TaskFill.swift
//  CRUD
//
//  Created by graphic on 2022-11-30.
//

import SwiftUI

enum TaskFilter: String {
    static var allFilters: [TaskFilter] {
        return [.NonCompleted, .Completed, .OverDue, .All]
    }
    
    case All = "All"
    case NonCompleted = "To Do"
    case Completed = "Completed"
    case OverDue = "Over Due"
    
}
