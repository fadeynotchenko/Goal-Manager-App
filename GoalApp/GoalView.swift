//
//  GoalView.swift
//  GoalApp
//
//  Created by Fadey Notchenko on 19.07.2022.
//

import SwiftUI

struct GoalView: View {
    
    var goal: Goal
    @Environment(\.colorScheme) var colorScheme
    
    @State var progress: CGFloat = 0
    
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
                .padding(5)
                
                Text("\(goal.current) / \(goal.price) \(valueArray[Int(goal.valueIndex)].symbol)")
                    .font(idiom == .pad ? .system(size: reader.size.width / 25) : .title2)
                    .bold()
                    .foregroundColor(.gray)
                
                Spacer()
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
                .stroke(lineWidth: idiom == .pad ? reader.size.width / 30 : 15)
                .foregroundColor(.gray.opacity(0.2))
            
            Circle()
                .trim(from: 0.0, to: min(progress, 1.0))
                .stroke(style: StrokeStyle(lineWidth: idiom == .pad ? reader.size.width / 30 : 15, lineCap: .round, lineJoin: .round))
                .fill(LinearGradient(colors: [colorArray[Int(goal.colorIndex)], .purple], startPoint: .leading, endPoint: .trailing))
                .rotationEffect(Angle(degrees: 270))
        }
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
}

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}
