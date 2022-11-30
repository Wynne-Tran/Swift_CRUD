//
//  DateHolder.swift
//  CRUD
//
//  Created by graphic on 2022-11-30.
//

import SwiftUI
import CoreData

class DateHolder: ObservableObject {
    @Published var date = Date()
    @Published var taskItems: [TaskItems] = []
    let calendar: Calendar = Calendar.current
    
    func moveDate(_ days: Int,_ context: NSManagedObjectContext) {
        date = calendar.date(byAdding: .day, value: days, to: date)!
        refeshTaskItems(context)
    }
    
    init(_ context: NSManagedObjectContext) {
        refeshTaskItems(context)
    }
    
    func refeshTaskItems(_ context: NSManagedObjectContext) {
        taskItems = fetchTaskItems(context)
    }
    
    
    
    func fetchTaskItems(_ context: NSManagedObjectContext) -> [TaskItems] {
        do {
            return try context.fetch(dailyTasksFetch()) as [TaskItems]
        } catch let error {
            fatalError("Unresolved error \(error)")
        }
    }
    
    func dailyTasksFetch() -> NSFetchRequest<TaskItems> {
        let request = TaskItems.fetchRequest()
        request.sortDescriptors = sortOrder()
        request.predicate = predicate()
        return request
    }
    
    private func sortOrder() -> [NSSortDescriptor] {
        let completedDateSort = NSSortDescriptor(keyPath: \TaskItems.completedDate, ascending: true)
        let timeSort = NSSortDescriptor(keyPath: \TaskItems.scheduleTime, ascending: true)
        let dueDateSort = NSSortDescriptor(keyPath: \TaskItems.dueDate, ascending: true)
        return [completedDateSort, timeSort, dueDateSort]
    }
    
    func predicate() -> NSPredicate {
        let start = calendar.startOfDay(for: date)
        let end = calendar.date(byAdding: .day, value: 1, to: start)!

        return NSPredicate(format: "dueDate >= %@ AND dueDate < %@", start as NSDate, end as NSDate)
    }
    
    func saveContext(_ context: NSManagedObjectContext){
        do {
            try context.save()
            refeshTaskItems(context)
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
