//
//  ReplenishmentView.swift
//  GoalApp
//
//  Created by Fadey Notchenko on 17.07.2022.
//

import SwiftUI

struct NotificationView: View {
    
    @Binding var isOnNotification: Bool
    @Binding var selectedTime: Int
    
    @State var isOn2 = false
    
    
    var body: some View {
        Form {
            Toggle(isOn: $isOnNotification) {
                Text("Добавить уведомление")
            }
            
            if isOnNotification {
                Picker("Присылать уведомление раз в", selection: $selectedTime) {
                    ForEach(0..<timeArray.count, id: \.self) { i in
                        Text(timeArray[i])
                    }
                }
                
                
                Section {
                    Toggle("Автопополнение", isOn: $isOn2)
                }
            }
        }
        .navigationTitle(Text("Уведомление"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ReplenishmentView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView(isOnNotification: .constant(true), selectedTime: .constant(0))
    }
}
