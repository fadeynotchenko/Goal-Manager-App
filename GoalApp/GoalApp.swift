//
//  GoalAppApp.swift
//  GoalApp
//
//  Created by Fadey Notchenko on 17.07.2022.
//

import SwiftUI

@main
struct GoalApp: App {
    
    @StateObject var vmDB = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vmDB)
                .environment(\.managedObjectContext, vmDB.container.viewContext)
        }
    }
}
