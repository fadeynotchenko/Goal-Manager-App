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
    
    @State var isOn = false
    @State var date = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section{
                    TextField("hint1", text: $goalName)
                        .focused($focus)
                } header: {
                    Text("name")
                }
                
                Section {
                    HStack {
                        TextField(valueArray[valueIndex].key, value: $goalPrice, format: .number)
                            .focused($focus)
                            .keyboardType(.numberPad)
                        
                        Picker("", selection: $valueIndex) {
                            ForEach(0..<valueArray.count, id: \.self) { i in
                                Text(valueArray[i].rawValue)
                            }
                        }.pickerStyle(.menu)
                    }
                    
                    TextField("save", value: $goalCurrent, format: .number)
                        .focused($focus)
                        .keyboardType(.numberPad)
                    
                } header: {
                    Text("cost")
                } footer: {
                    Text("amount")
                }
                .listRowSeparator(.hidden)
                
                Section {
                    Toggle("limit", isOn: $isOn)
                    
                    if isOn {
                        DatePicker("finish", selection: $date, in: Date()..., displayedComponents: .date)
                            .environment(\.locale, Locale.init(identifier: String(Locale.preferredLanguages[0].prefix(2))))
                    }
                }
                .listRowSeparator(.hidden)
                
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
                    Text("tags")
                }
                
            }
            .navigationTitle(Text("newGoal"))
            .toolbar {
                ToolbarItem {
                    Button("add") {
                        openNewGoalView.toggle()
                        //action add
                        DispatchQueue.main.async {
                            vmDB.addGoal(name: goalName, allPrice: goalPrice!, current: goalCurrent ?? 0, valueIndex: Int16(valueIndex), tagIndex: Int16(tagIndex), dateFinish: isOn ? date : nil, context: managedObjectContext)
                        }
                        
                    }
                    .disabled(goalName.isEmpty ? true : false)
                    .disabled(goalPrice == nil ? true : false)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("close") {
                        openNewGoalView.toggle()
                    }
                }
                
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("done") {
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
    
    var key: LocalizedStringKey {
        switch self {
        case .rub:
            return "cost1"
        case .usd:
            return "cost2"
        case .eur:
            return "cost3"
        }
    }
}

struct NewGoalView_Previews: PreviewProvider {
    static var previews: some View {
        NewGoalView(openNewGoalView: .constant(true))
            .environmentObject(DataController())
        
    }
}
