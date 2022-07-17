//
//  GoalAppApp.swift
//  GoalApp
//
//  Created by Fadey Notchenko on 17.07.2022.
//

import SwiftUI

@main
struct GoalAppApp: App {
    
    @StateObject var vm = RealmViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
            
        }
    }
}
