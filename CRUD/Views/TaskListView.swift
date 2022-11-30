//
//  ContentView.swift
//  CRUD
//
//  Created by graphic on 2022-11-29.
//

import SwiftUI
import CoreData

struct TaskListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder

    @State var selectedFilter = TaskFilter.NonCompleted
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \TaskItems.dueDate, ascending: true)],
//        animation: .default)
//    
//    private var items: FetchedResults<TaskItems>

    var body: some View {
        NavigationView {
            
            VStack{
                DateScroller()
                    .padding()
                    .environmentObject(dateHolder)
                ZStack {
                    List {
                        ForEach(filterdTaskItems()) { item in
                            NavigationLink(destination: TaskEditView(passedTaskItem: item, initialDate: Date()).environmentObject(dateHolder))
                            {
                                TaskCell(passedTaskItem: item).environmentObject(dateHolder)
                                
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
//                    .toolbar {
//                        ToolbarItem(placement: .navigationBarTrailing) {
//                            EditButton()
//                        }
//                    }
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Picker("", selection: $selectedFilter.animation()) {
                                ForEach(TaskFilter.allFilters, id: \.self) {
                                    filter in Text(filter.rawValue)
                                }
                            }                        }
                    }
                    FloatingButton().environmentObject(dateHolder)
                }
                    
                }.navigationTitle("To Do List")
        }
    }
    
    private func filterdTaskItems() -> [TaskItems] {
        if selectedFilter == TaskFilter.Completed {
            return dateHolder.taskItems.filter{
                $0.isCompleted()
            }
        }
        if selectedFilter == TaskFilter.NonCompleted {
            return dateHolder.taskItems.filter {
                !$0.isCompleted()
            }
        }
        if selectedFilter == TaskFilter.OverDue {
            return dateHolder.taskItems.filter{
                $0.isOverDue()
            }
        }
        return dateHolder.taskItems
    }

    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { dateHolder.taskItems[$0] }.forEach(viewContext.delete)

            dateHolder.saveContext(viewContext)
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
