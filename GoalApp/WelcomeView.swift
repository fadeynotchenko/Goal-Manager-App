//
//  WelcomeView.swift
//  GoalApp
//
//  Created by Fadey Notchenko on 17.07.2022.
//

import SwiftUI

struct WelcomeView: View {
    
    @State private var count = 0
    @State private var openMainView = false
    private let welcomeTextArray = ["Добро пожаловать в 'Моя Копилка'", "Со мной копить еще удобнее!", "Давай добавим твою первую цель"]
    
    var body: some View {
        ZStack {
            
            Color("Color").edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Spacer()
                
                Text(welcomeTextArray[count])
                    .bold()
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                    .id(welcomeTextArray[count])
                
                Spacer()
                
                Text(count == 0 ? "Нажмите на текст, чтобы продожить" : " ")
                    .foregroundColor(.gray)
            }
            .fullScreenCover(isPresented: $openMainView) {
                MainView(openNewGoalView: true)
            }
            
        }
        .onTapGesture {
            withAnimation(.linear(duration: 0.25)) {
                if count < welcomeTextArray.count - 1 {
                    count += 1
                } else {
                    UserDefaults.standard.set(true, forKey: "firstEntry")
                    openMainView = true
                }
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environmentObject(DataController())
    }
}
