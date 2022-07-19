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
        NavigationView {
            ZStack {
                List {
                    ForEach(goals) { goal in
                        GoalRow(goal: goal)
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
                
                if goals.isEmpty {
                    Text("Список пуст")
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle(Text("Моя копилка"))
            .sheet(isPresented: $openNewGoalView) {
                NewGoalView(openNewGoalView: $openNewGoalView)
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
        .accentColor(.red)
        .navigationViewStyle(.stack)
        
    }
    
}

struct GoalRow: View {
    
    let goal: Goal
    
    var body: some View {
        NavigationLink(destination: {
            
        }) {
            HStack {
                Circle()
                    .fill(colorArray[Int(goal.tagIndex)])
                    .frame(width: 30, height: 30)
                
                VStack(alignment: .leading) {
                    Text(goal.name!)
                        .bold()
                        .font(.title2)
                    
                    Text("\(goal.current) / \(goal.price) \(valueArray[Int(goal.valueIndex)].symbol)")
                    
                }
                .padding(.horizontal)
            }
            .padding(5)
        }.accentColor(.red)
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(DataController())
    }
}
