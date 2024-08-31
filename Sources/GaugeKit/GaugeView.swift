//
//  GaugeView.swift
//  CryptoCheck
//
//  Created by Anton Martinsson on 2021-06-19.
//
//  A Gauge similar to the gauges used for some Apple Watch complications.

import SwiftUI

/**
 A view ideal for visualizing a value between in a gauge,
 not too different from the native gauges used by Apple for some Apple Watch complications.
 
 - Parameters:
 - title: A decriptive string value to display inside the gauge.
 - value: An integer displayed inside the gauge, which also determines the position of the gauge's indicator.
 - maxValue: An integer value representing what the gauge should max out at. Defaults to nil if `value` is also nil, and to 100 if a `value` is set, but no explicit `maxValue`.
 - colors: The colors that should be used in the gradient that wipes across the gauge.
 - additionalInfo: A struct containing three (optional) strings to display when the user taps on the gauge.
 */
public struct GaugeView : View {
    @State private var flipped: Bool = false
    
    let title: String?
    let value: Int?
    let maxValue: Int?
    let colors: [Color]
    let additionalInfo: GaugeAdditionalInfo?
    
    public init(
        title: String? = nil,
        value: Int? = nil,
        maxValue: Int? = nil,
        colors: [Color],
        additionalInfo: GaugeAdditionalInfo? = nil
    ) {
        self.title = title
        self.value = value
        self.maxValue = maxValue
        self.colors = colors
        self.additionalInfo = additionalInfo
    }
    
    private var flipAngle: Angle {
        Angle(degrees: flipped ? 180 : 0)
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                ZStack {
                    GaugeMeter(value: value, maxValue: maxValue, colors: colors)
                    GaugeLabelStack(value: value, title: title)
                }
                .rotation3DEffect(flipAngle, axis: (x: 0, y: 1, z: 0))
                .opacity(flipped ? 0.05 : 1)
                
                if let info = additionalInfo {
                    GaugeBackView(flipped: $flipped, additionalInfo: info)
                }
            }
            .offset(y: geometry.size.height * 0.05)
            .onTapGesture {
                if additionalInfo != nil {
                    withAnimation {
                        self.flipped.toggle()
                    }
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    GaugeView(
        title: "Speed",
        value: 100,
        colors: [.red, .orange, .yellow, .green],
        additionalInfo: .init(
            strap: "This is the top title",
            title: "Title",
            body: "Hejsan svejsan")
    )
    .padding()
}
