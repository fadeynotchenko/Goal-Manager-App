//
//  GoalView.swift
//  GoalApp
//
//  Created by Fadey Notchenko on 19.07.2022.
//

import SwiftUI

struct GoalView: View {
    
    var goal: Goal
    @Binding var percent: CGFloat
    @State var progress: CGFloat = 0
    
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            Color("Color").edgesIgnoringSafeArea(.all)
            
            ScrollView {
                ZStack(alignment: .center) {
                    CircleProgressView(progress: $progress, color: colorArray[Int(goal.tagIndex)])
                        .frame(width: width / 2.2, height: width / 2)
                    
                    Text("\(Int(percent))%")
                        .font(.system(size: 40))
                        .bold()
                }
                .padding()
                
                Text("\(goal.current) / \(goal.price) \(valueArray[Int(goal.valueIndex)].symbol)")
                    .font(.title2)
                    .bold()
                    .padding()
                    .foregroundColor(.gray)
                
                Spacer()
            }
            .navigationTitle(Text(goal.name!))
            .task {
                withAnimation(.easeInOut(duration: 2.0)) {
                    progress = percent / 100
                }
            }
        }
    }
}

struct CircleProgressView: View {
    
    @Binding var progress: CGFloat
    let color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 30.0)
                .foregroundColor(.gray.opacity(0.2))
            
            Circle()
                .trim(from: 0.0, to: min(progress, 1.0))
                .stroke(style: StrokeStyle(lineWidth: 30.0, lineCap: .round, lineJoin: .round))
                .fill(LinearGradient(colors: [color, .purple], startPoint: .leading, endPoint: .trailing))
                .rotationEffect(Angle(degrees: 270))
        }
    }
}

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}
