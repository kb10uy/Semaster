import SwiftUI

/// Editable checkin property view.
struct CheckinProperty: View {
    @Binding var value: Double
    let captionKey: LocalizedStringKey
    let color: Color
    
    var body: some View {
        ZStack {
            CircularGauge(
                value: Binding(get: { value / 5.0 }, set: { _ in }),
                width: 15.0,
                color: color
            )
            
            VStack {
                Text("\(value, specifier: "%.1f")")
                    .font(.title2)
                    .focusable(true)
                    .digitalCrownRotation(
                        $value,
                        from: 0.0,
                        through: 5.0,
                        by: 0.5,
                        sensitivity: .low,
                        isContinuous: false,
                        isHapticFeedbackEnabled: true
                    )
                Text(captionKey)
                    .font(.caption)
            }
        }
    }
}

struct CheckinProperty_Previews: PreviewProvider {
    static var previews: some View {
        CheckinProperty(
            value: Binding(get: { 0.5 }, set: { _ in }),
            captionKey: "Caption.Quality",
            color: Color("CheckinQuality")
        )
    }
}
