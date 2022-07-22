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
    private let welcomeTextArray: [LocalizedStringKey] = ["welcome1", "welcome2", "welcome3"]
    
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
                
                Spacer()
                
                Text(count == 0 ? "welcomeHint" : " ")
                    .foregroundColor(.gray)
            }
            .fullScreenCover(isPresented: $openMainView) {
                MainView(openNewGoalView: true)
            }
            
        }
        .onTapGesture {
            withAnimation {
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

