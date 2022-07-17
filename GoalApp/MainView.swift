//
//  MainView.swift
//  GoalApp
//
//  Created by Fadey Notchenko on 17.07.2022.
//

import SwiftUI

struct MainView: View {
    
    @State var openNewGoalView = false
    @EnvironmentObject var vm: RealmViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(vm.goals, id: \.id) { goal in
                        
                        GoalRow(goal: goal)
                            .contextMenu {
                                Button("Удалить") {
                                    vm.deleteData(goal: goal)
                                }
                            }
                        
                    }
                }
                
                if vm.goals.isEmpty {
                    Text("Список пуст")
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle(Text("Моя копилка"))
            .sheet(isPresented: $openNewGoalView) {
                NewGoalView(openNewGoalView: $openNewGoalView)
                    .environmentObject(vm)
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
    
    let goal: GoalItem
    @EnvironmentObject var vm: RealmViewModel
    
    var body: some View {
        NavigationLink(destination: {
            
        }) {
            HStack {
                Circle()
                    .fill(colorArray[goal.tagIndex])
                    .frame(width: 50, height: 50)
                
                VStack(alignment: .leading) {
                    Text(goal.goalName)
                        .bold()
                    
                    Text("\(goal.goalPrice) \(valueArray[goal.valueIndex])")
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
            .environmentObject(RealmViewModel())
    }
}
