//
//  NewGoalView.swift
//  GoalApp
//
//  Created by Fadey Notchenko on 17.07.2022.
//

import SwiftUI
import CoreData

struct NewGoalView: View {
    
    @Binding var openNewGoalView: Bool
    @FocusState var focus: Bool
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var vmDB: DataController
    
    @State var goalName = ""
    @State var goalPrice: Int64?
    @State var goalCurrent: Int64?
    @State var valueIndex = 0
    @State var tagIndex = 0
    
    @State var selectedTime = 0
    @State var isOnNotification = false
    
    var body: some View {
        NavigationView {
            Form {
                Section{
                    TextField("Например: 'Машина' или 'Квартира'", text: $goalName)
                        .focused($focus)
                } header: {
                    Text("Название")
                }
                
                Section {
                    HStack {
                        TextField("Цена в \(valueArray[valueIndex].symbol)", value: $goalPrice, format: .number)
                            .focused($focus)
                            .keyboardType(.numberPad)
                        
                        Picker("", selection: $valueIndex) {
                            ForEach(0..<valueArray.count, id: \.self) { i in
                                Text(valueArray[i].rawValue)
                            }
                        }.pickerStyle(.menu)
                    }
                    
                    TextField("Накопления (Необязательно)", value: $goalCurrent, format: .number)
                        .focused($focus)
                        .keyboardType(.numberPad)
                    
                } header: {
                    Text("Стоимость")
                } footer: {
                    Text("Сумма которая имеется сейчас")
                }
                .listRowSeparator(.hidden)
                
                Section{
                    NavigationLink(destination: {
                        
                        
                    }) {
                        VStack(alignment: .leading) {
                            Text("Подробнее")
                                .font(.headline)
                            
                            if isOnNotification {
                                Text("Раз в \(timeArray[selectedTime])")
                            } else {
                                Text("Никогда")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                } header: {
                    Text("Уведомление")
                }
                
                Section {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(0..<colorArray.count, id: \.self) { i in
                                Circle()
                                    .fill(colorArray[i])
                                    .frame(width: 30, height: 30)
                                    .background {
                                        if tagIndex == i {
                                            Circle()
                                                .fill(.gray)
                                                .padding(-3)
                                        }
                                    }
                                    .onTapGesture {
                                        tagIndex = i
                                    }
                                    .padding(5)
                            }
                        }
                    }
                } header: {
                    Text("Теги")
                }
                
            }
            .navigationTitle(Text("Новая цель"))
            .toolbar {
                ToolbarItem {
                    Button("Добавить") {
                        openNewGoalView.toggle()
                        //action add
                        DispatchQueue.main.async {
                            vmDB.addGoal(name: goalName, allPrice: goalPrice!, current: goalCurrent ?? 0, valueIndex: Int16(valueIndex), tagIndex: Int16(tagIndex), context: managedObjectContext)
                        }
                        
                    }
                    .disabled(goalName.isEmpty ? true : false)
                    .disabled(goalPrice == nil ? true : false)
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
        .accentColor(.purple)
        .navigationViewStyle(.stack)
    }
}

enum Value: String {
    case rub = "RUB"
    case usd = "USD"
    case eur = "EUR"
    
    var symbol: String {
        switch self {
        case .rub:
            return "₽"
        case .usd:
            return "$"
        case .eur:
            return "€"
        }
    }
}

struct NewGoalView_Previews: PreviewProvider {
    static var previews: some View {
        NewGoalView(openNewGoalView: .constant(true))
            .environmentObject(DataController())
        
    }
}
