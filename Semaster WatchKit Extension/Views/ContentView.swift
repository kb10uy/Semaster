//
//  ContentView.swift
//  Semaster WatchKit Extension
//
//  Created by Yū Kobayashi on 2022/03/26.
//

import SwiftUI

struct ContentView: View {
    @State var qualityValue: CGFloat = 0.5
    
    var body: some View {
        ZStack {
            CircularGauge(
                value: Binding(get: { qualityValue / 5.0 }, set: { _ in }),
                width: 15.0,
                color: Color("CheckinQuality")
            )
            Text("\(qualityValue, specifier: "%.1f")")
                .font(.title)
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
