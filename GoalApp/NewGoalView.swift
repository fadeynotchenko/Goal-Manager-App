//
//  NewGoalView.swift
//  GoalApp
//
//  Created by Fadey Notchenko on 17.07.2022.
//

import SwiftUI

struct NewGoalView: View {
    
    @Binding var openNewGoalView: Bool
    
    @State var goalName = ""
    @State var goalPrice = ""
    @State var goalCurrent = ""
    @State var selectedValue = 0
    
    var valueArray = ["RUB", "USD", "EUR"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(content: {
                    TextField("Например: 'Машина' или 'Квартира'", text: $goalName)
                }, header: {
                    Text("Название")
                })
                
                Section(content: {
                    TextField("Цена в \(valueArray[selectedValue])", text: $goalPrice)
                    
                    Picker("", selection: $selectedValue) {
                        ForEach(0..<valueArray.count, id: \.self) { i in
                            Text(valueArray[i])
                        }
                    }.pickerStyle(.segmented)
                }, header: {
                    Text("Стоимость")
                }).listRowSeparator(.hidden)
                
                Section(content: {
                    TextField("(Необязательно)", text: $goalCurrent)
                }, header: {
                    Text("Накопления")
                }, footer: {
                    Text("Сумма которая имеется сейчас")
                })
                
                
            }
            .navigationTitle(Text("Новая цель"))
            .toolbar {
                ToolbarItem {
                    Button("Добавить") {
                        //action add
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Закрыть") {
                        openNewGoalView.toggle()
                    }
                }
            }
            
        }
        .accentColor(.red)
        .navigationViewStyle(.stack)
    }
}

struct NewGoalView_Previews: PreviewProvider {
    static var previews: some View {
        NewGoalView(openNewGoalView: .constant(true))
    }
}
