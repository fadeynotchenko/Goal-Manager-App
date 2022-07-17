//
//  MainView.swift
//  GoalApp
//
//  Created by Fadey Notchenko on 17.07.2022.
//

import SwiftUI

struct MainView: View {
    
    @State var openNewGoalView = false
    
    var body: some View {
        NavigationView {
            List {
                
            }
            .navigationTitle(Text("Моя копилка"))
            .sheet(isPresented: $openNewGoalView) {
                Text("test")
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        openNewGoalView.toggle()
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
