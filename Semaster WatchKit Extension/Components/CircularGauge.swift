import SwiftUI

/// Shows progress/value in circular stroke.
struct CircularGauge: View {
    @Binding var value: CGFloat
    let width: CGFloat
    let color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: width)
                .foregroundColor(color)
                .opacity(0.2)
                .padding()
            Circle()
                .trim(from: 0.0, to: value)
                .stroke(style: StrokeStyle(lineWidth: width, lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle(degrees: 270))
                .foregroundColor(color)
                .padding()
        }
    }
}

struct CircularGauge_Previews: PreviewProvider {
    static var previews: some View {
        CircularGauge(
            value: Binding(get: { 0.5 }, set: { _ in }),
            width: 15.0,
            color: Color("CheckinQuality")
        )
    }
}
