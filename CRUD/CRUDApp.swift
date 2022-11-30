//
//  CRUDApp.swift
//  CRUD
//
//  Created by graphic on 2022-11-29.
//

import SwiftUI

@main
struct CRUDApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
