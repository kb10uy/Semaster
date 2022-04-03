import SwiftUI

struct AmountEditView: View {
    @State var amountValue: CGFloat = 0.5
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    CircularGauge(
                        value: Binding(get: { amountValue / 5.0 }, set: { _ in }),
                        width: 15.0,
                        color: Color("CheckinAmount")
                    )
                    VStack {
                        Text("\(amountValue, specifier: "%.1f")")
                            .font(.title2)
                            .focusable(true)
                            .digitalCrownRotation(
                                $amountValue,
                                from: 0.0,
                                through: 5.0,
                                by: 0.5,
                                sensitivity: .low,
                                isContinuous: false,
                                isHapticFeedbackEnabled: true
                            )
                        Text("Caption.Amount")
                            .font(.caption)
                    }
                }
                Button(action: {}) {
                    Text("Action.Commit")
                }
            }
            .navigationTitle("Title.Amount")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AmountEditView_Previews: PreviewProvider {
    static var previews: some View {
        AmountEditView()
    }
}
