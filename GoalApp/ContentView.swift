//
//  ContentView.swift
//  GoalApp
//
//  Created by Fadey Notchenko on 17.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var firstEntry = UserDefaults.standard.bool(forKey: "firstEntry")
    
    var body: some View {
        if firstEntry {
            MainView()
        } else {
            WelcomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
