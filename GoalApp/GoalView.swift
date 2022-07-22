//
//  GoalView.swift
//  GoalApp
//
//  Created by Fadey Notchenko on 19.07.2022.
//

import SwiftUI

struct GoalView: View {
    
    var goal: Goal
    
    @State var progress: CGFloat = 0
    @Environment(\.colorScheme) var colorScheme
    
    private func lostDays() -> Int {
        return Calendar.current.component(.day, from: Date()) - Calendar.current.component(.day, from: goal.date!)
    }
    
    private func endDays() -> Int {
        return Calendar.current.component(.day, from: goal.dateFinish!) - lostDays()
    }
    
    var body: some View {
        GeometryReader { reader in
            
            ScrollView {
                ZStack(alignment: .center) {
                    
                    HStack(spacing: idiom == .pad ? reader.size.width / 20 : 10) {
                        sideButton(systemName: "minus", reader: reader) {
                            
                        }
                        
                        circleProgressView(reader: reader)
                            .padding()
                            .frame(width: idiom == .pad ? reader.size.width / 2.5 : reader.size.width / 1.7, height: idiom == .pad ? reader.size.width / 2.5 : reader.size.width / 1.7)
                        
                        sideButton(systemName: "plus", reader: reader) {
                            
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text("\(Int(goal.current / (goal.price / 100)))%")
                        .font(.system(size: idiom == .pad ? reader.size.width / 20 : 40))
                        .bold()
                    
                    
                }
                .padding()
                
                Text("\(goal.current) / \(goal.price) \(valueArray[Int(goal.valueIndex)].symbol)")
                    .font(idiom == .pad ? .system(size: reader.size.width / 25) : .title2)
                    .bold()
                
                HStack {
                    Spacer()
                    
                    detailButton(title: "Вы копите:", subtitle: "\(lostDays()) дней")
                    
                    Spacer()
                    
                    detailButton(title: "Осталось:", subtitle: goal.dateFinish != nil ? "\(endDays()) дней" : "-")
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle(Text(goal.name!))
            .task {
                withAnimation(.easeInOut(duration: 2.0)) {
                    progress = CGFloat(goal.current / (goal.price / 100)) / 100
                }
            }
            
        }
    }
    
    @ViewBuilder
    private func circleProgressView(reader: GeometryProxy) -> some View {
        ZStack {
            Circle()
                .stroke(lineWidth: idiom == .pad ? reader.size.width / 35 : 15)
                .foregroundColor(Color(uiColor: .secondarySystemFill))
            
            Circle()
                .trim(from: 0.0, to: min(progress, 1.0))
                .stroke(style: StrokeStyle(lineWidth: idiom == .pad ? reader.size.width / 35 : 15, lineCap: .round, lineJoin: .round))
                .fill(LinearGradient(colors: [colorArray[Int(goal.colorIndex)], .purple], startPoint: .leading, endPoint: .trailing))
                .rotationEffect(Angle(degrees: 270))
        }
        .frame(maxWidth: 400, alignment: .center)
    }
    
    @ViewBuilder
    private func sideButton(systemName: String, reader: GeometryProxy, action: @escaping () -> ()) -> some View {
        Button(action: { action() }) {
            Image(systemName: systemName)
                .frame(width: idiom == .pad ? reader.size.width / 10 : 50, height: idiom == .pad ? reader.size.width / 10 : 50)
                .font(idiom == .pad ? .system(size: reader.size.width / 20) : .system(size: 15))
                .background(Color(uiColor: .secondarySystemFill))
                .clipShape(Circle())
        }
    }
    
    @ViewBuilder
    private func detailButton(title: String, subtitle: String) -> some View {
        VStack(spacing: 5) {
            Text(title)
                .foregroundColor(.gray)
                .bold()
                
            Text(subtitle)
                .font(.title2)
                .bold()
                .gradientForeground(colors: [colorArray[Int(goal.colorIndex)], .purple])
                
                
        }
        .padding()
        .frame(maxWidth: 150)
        .background(Color(uiColor: .secondarySystemFill))
        .cornerRadius(15)
    }
}

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)).mask(self)
    }
}
