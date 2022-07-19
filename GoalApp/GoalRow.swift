import SwiftUI

struct GoalRow: View {
    
    let goal: Goal
    @State var percent: CGFloat = 0
    
    var body: some View {
        NavigationLink(destination: {
            GoalView(goal: goal, percent: $percent)
        }) {
            HStack(spacing: 0) {
                VStack {
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    VStack(alignment: .leading, spacing: 100) {
                        Text(goal.name!)
                            .bold()
                            .font(.title3)
                    }
                    
                    CapsuleProgressView(goal: goal, percent: $percent)
                    
                    
                    Text("\(goal.current) / \(goal.price) \(valueArray[Int(goal.valueIndex)].symbol)")
                        .foregroundColor(.gray)
                        .bold()
                    
                }
            }
            
        }
        .accentColor(.red)
    }
    
}

struct CapsuleProgressView: View {
    
    let goal: Goal
    @Binding var percent: CGFloat
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            ZStack(alignment: .trailing) {
                HStack {
                    Capsule()
                        .fill(.gray.opacity(0.2))
                        .frame(width: width / 2, height: 12)
                    
                    Text("\(Int(percent)) %")
                        .foregroundColor(.gray)
                        .bold()
                }
            }
            
            Capsule()
                .fill(LinearGradient(colors: [.purple, colorArray[Int(goal.tagIndex)]], startPoint: .leading, endPoint: .trailing))
                .frame(width: percent / 200 * width, height: 12)
        }
        .task {
            withAnimation(.linear(duration: 1.0)) {
                percent = CGFloat(goal.current / (goal.price / 100))
            }
        }
    }
}
