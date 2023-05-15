//
//  SpendingTrackerApp.swift
//  SpendingTracker
//
//  Created by Yigit Karakurt on 15.05.2023.
//

import SwiftUI

@main
struct SpendingTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
