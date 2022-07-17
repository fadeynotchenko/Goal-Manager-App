//
//  NewGoalView.swift
//  GoalApp
//
//  Created by Fadey Notchenko on 17.07.2022.
//

import SwiftUI
import RealmSwift

var arrayTime = ["День", "Неделю", "Месяц", "Год"]
var valueArray = ["RUB", "USD", "EUR"]
var colorArray: [Color] = [.red, .orange, .yellow, .green, .blue, .cyan, .purple, .pink, .indigo, .brown]

struct NewGoalView: View {
    
    @Binding var openNewGoalView: Bool
    
    @EnvironmentObject var vm: RealmViewModel
    
    @State var selectedTime = 0
    @State var isOnNotification = false
    
    @FocusState var focus: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section(content: {
                    TextField("Например: 'Машина' или 'Квартира'", text: $vm.goalName)
                        .focused($focus)
                }, header: {
                    Text("Название")
                })
                
                Section(content: {
                    TextField("Цена в \(valueArray[vm.valueIndex])", text: $vm.goalPrice)
                        .focused($focus)
                        .keyboardType(.numberPad)
                    
                    Picker("", selection: $vm.valueIndex) {
                        ForEach(0..<valueArray.count, id: \.self) { i in
                            Text(valueArray[i])
                        }
                    }.pickerStyle(.segmented)
                }, header: {
                    Text("Стоимость")
                })
                .listRowSeparator(.hidden)
                
                Section(content: {
                    TextField("(Необязательно)", text: $vm.goalCurrent)
                        .focused($focus)
                        .keyboardType(.numberPad)
                }, header: {
                    Text("Накопления")
                }, footer: {
                    Text("Сумма которая имеется сейчас")
                })
                
                Section(content: {
                    NavigationLink(destination: {
                        NotificationView(isOnNotification: $isOnNotification, selectedTime: $selectedTime)
                        
                    }) {
                        VStack(alignment: .leading) {
                            Text("Подробнее")
                                .font(.headline)
                            
                            if isOnNotification {
                                Text("Раз в \(arrayTime[selectedTime])")
                            } else {
                                Text("Никогда")
                                    .font(.subheadline)
                            }
                        }
                    }
                }, header: {
                    Text("Уведомление")
                })
                
                Section(content: {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(0..<colorArray.count, id: \.self) { i in
                                Circle()
                                    .fill(colorArray[i])
                                    .frame(width: 30, height: 30)
                                    .background {
                                        if vm.tagIndex == i {
                                            Circle()
                                                .fill(.gray)
                                                .padding(-3)
                                        }
                                    }
                                    .onTapGesture {
                                        vm.tagIndex = i
                                    }
                                    .padding(5)
                            }
                        }
                    }
                }, header: {
                    Text("Теги")
                })
                
            }
            .navigationTitle(Text("Новая цель"))
            .toolbar {
                ToolbarItem {
                    Button("Добавить") {
                        //action add
                        vm.addData()
                        openNewGoalView.toggle()
                    }
                    .disabled(vm.goalName.isEmpty ? true : false)
                    .disabled(vm.goalPrice.isEmpty ? true : false)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Закрыть") {
                        openNewGoalView.toggle()
                    }
                }
                
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Готово") {
                        focus.toggle()
                    }
                }
            }
            
        }
        .accentColor(.red)
        .navigationViewStyle(.stack)
        .onDisappear {
            vm.deInitData()
        }
    }
}

struct NewGoalView_Previews: PreviewProvider {
    static var previews: some View {
        NewGoalView(openNewGoalView: .constant(true))
            .environmentObject(RealmViewModel())
    }
}
