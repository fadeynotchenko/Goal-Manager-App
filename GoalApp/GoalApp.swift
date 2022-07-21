//
//  GoalAppApp.swift
//  GoalApp
//
//  Created by Fadey Notchenko on 17.07.2022.
//

import SwiftUI

var timeArray = ["День", "Неделю", "Месяц", "Год"]
var valueArray: [Value] = [.rub, .usd, .eur]
var colorArray: [Color] = [.red, .orange, .yellow, .green, .blue, .cyan, .purple, .pink, .indigo, .brown]

var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }

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
