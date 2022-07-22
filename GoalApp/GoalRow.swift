import SwiftUI

struct GoalRow: View {
    
    let goal: Goal
    var reader: GeometryProxy
    
    @State var percent: CGFloat = 0
    
    var body: some View {
            NavigationLink(destination: {
                GoalView(goal: goal)
            }) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(goal.name!)
                        .bold()
                        .font(.title3)
                    
                    capsuleProgressView()
                    
                    Text("\(goal.current) / \(goal.price) \(valueArray[Int(goal.valueIndex)].symbol)")
                        .foregroundColor(.gray)
                        .bold()
                    
                }
                .padding(.vertical)
                
                
            }
            .accentColor(.red)
            .frame(width: reader.size.width)
    }
    
    @ViewBuilder
    func capsuleProgressView() -> some View {
        ZStack(alignment: .leading) {
            
            ZStack(alignment: .trailing) {
                HStack {
                    Capsule()
                        .fill(Color(uiColor: .secondarySystemFill))
                        .frame(width: idiom == .pad ? reader.size.width / 3 : reader.size.width / 2, height: 12)
                    
                    Text("\(Int(goal.current / (goal.price / 100))) %")
                        .foregroundColor(.gray)
                        .bold()
                }
            }
            
            Capsule()
                .fill(LinearGradient(colors: [.purple, colorArray[Int(goal.colorIndex)]], startPoint: .leading, endPoint: .trailing))
                .frame(width: percent / 200 * reader.size.width, height: 12)
        }
        .task {
            withAnimation(.linear(duration: 1.0)) {
                percent = CGFloat(goal.current / (goal.price / 100))
            }
        }
    }
    
}
