//
//  MainView.swift
//  GoalApp
//
//  Created by Fadey Notchenko on 17.07.2022.
//

import SwiftUI
import CoreData

struct MainView: View {
    
    @State var openNewGoalView = false
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var vmDB: DataController
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var goals: FetchedResults<Goal>
    
    var body: some View {
        GeometryReader { reader in
            NavigationView {
                ZStack {
                    List {
                        ForEach(goals) { goal in
                            Section {
                                GoalRow(goal: goal, reader: reader)
                                    .swipeActions {
                                        Button(role: .destructive) {
                                            withAnimation() {
                                                vmDB.deleteGoal(goal: goal, context: managedObjectContext)
                                            }
                                        } label: {
                                            Label("", systemImage: "trash")
                                        }
                                    }
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                    
                    if goals.isEmpty {
                        Text("listEmpty")
                            .foregroundColor(.gray)
                    }
                }
                .navigationTitle(Text("appName"))
                .sheet(isPresented: $openNewGoalView) {
                    NewGoalView(openNewGoalView: $openNewGoalView)
                }
                .toolbar {
                    ToolbarItem {
                        Button(action: {
                            openNewGoalView.toggle()
                        }) {
                            Image(systemName: "plus")
                        }
                        
                    }
                }
            }
            .accentColor(.purple)
            .navigationViewStyle(.stack)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(DataController())
    }
}
