import SwiftUI

struct QualityEditView: View {
    @State var qualityValue: CGFloat = 0.5
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    CircularGauge(
                        value: Binding(get: { qualityValue / 5.0 }, set: { _ in }),
                        width: 15.0,
                        color: Color("CheckinQuality")
                    )
                    VStack {
                        Text("\(qualityValue, specifier: "%.1f")")
                            .font(.title2)
                            .focusable(true)
                            .digitalCrownRotation(
                                $qualityValue,
                                from: 0.0,
                                through: 5.0,
                                by: 0.5,
                                sensitivity: .low,
                                isContinuous: false,
                                isHapticFeedbackEnabled: true
                            )
                        Text("Caption.Quality")
                            .font(.caption)
                    }
                }
                NavigationLink(destination: AmountEditView()) {
                    Text("Action.Next")
                }
            }
            .navigationTitle("Title.Quality")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct QualityEditView_Previews: PreviewProvider {
    static var previews: some View {
        QualityEditView()
    }
}
