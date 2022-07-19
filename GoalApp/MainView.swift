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
                        Section {
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
                    }
                    
                }
            }
        }
        .accentColor(.purple)
        .navigationViewStyle(.stack)
        
    }
    
}

struct GoalRow: View {
    
    let goal: Goal
    
    var body: some View {
        NavigationLink(destination: {
            VStack {
                //
            }.navigationTitle(Text(goal.name!))
        }) {
            HStack(spacing: 0) {
                VStack {
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    VStack(alignment: .leading, spacing: 100) {
                        Text(goal.name!)
                            .bold()
                            .font(.title2)
                    }
                    
                    CapsuleProgressView(goal: goal)
                    
                    Text("\(goal.current) / \(goal.price) \(valueArray[Int(goal.valueIndex)].symbol)")
                        .foregroundColor(.gray)
                    
                }
            }
            
        }
        .accentColor(.red)
    }
    
}

struct CapsuleProgressView: View {
    
    let goal: Goal
    @State var percent: CGFloat = 0
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            ZStack(alignment: .trailing) {
                HStack {
                Capsule()
                    .fill(.gray.opacity(0.5))
                    .frame(width: width / 2, height: 12)
                    
                    Text("\(Int(percent)) %")
                        .foregroundColor(.gray)
                        .bold()
                }
            }
            
            Capsule()
                .fill(LinearGradient(colors: [.purple, colorArray[Int(goal.tagIndex)]], startPoint: .leading, endPoint: .trailing))
                .frame(width: percent / 200 * width, height: 12)
        }
        .task {
            withAnimation(.linear(duration: 0.5)) {
                percent = CGFloat(goal.current / (goal.price / 100))
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(DataController())
    }
}
