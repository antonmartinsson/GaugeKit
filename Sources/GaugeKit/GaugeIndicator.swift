//
//  GaugeIndicator.swift
//  GaugeIndicator
//
//  Created by Anton Martinsson on 2021-07-30.
//

import SwiftUI

@available(iOS 16.0, macOS 13.0, watchOS 9.0, *)
struct GaugeIndicator: View {
    #if !os(visionOS)
    @Environment(\.widgetRenderingMode) private var renderingMode
    #endif
    @Environment(\.indicatorColor) private var indicatorColor
    @Environment(\.meterThickness) private var customMeterThickness
    
    let angle: Angle
    let frame: CGSize
    
    var body: some View {
        let standardMeterThickness = frame.width / 10
        let strokeThickness = (customMeterThickness ?? standardMeterThickness) / 2
        
        ZStack {
            if let indicatorColor {
                Circle()
                    .stroke(lineWidth: strokeThickness)
                    .scaleAndPlaceIndicator(in: frame, thickness: strokeThickness)
                    .rotationEffect(Angle(degrees: 126))
                    .rotationEffect(angle, anchor: .center)
                    .foregroundStyle(indicatorColor)
                    #if !os(visionOS)
                    .shadow(
                        color: .black.opacity(renderingMode == .accented ? 0 : 0.2),
                        radius: 2
                    )
                    #else
                    .shadow(color: .black.opacity(0.2), radius: 2)
                    #endif
                Circle()
                    .strokeBorder(lineWidth: 1)
                    .scaleAndPlaceIndicator(in: frame, thickness: strokeThickness, stroke: true)
                    .rotationEffect(Angle(degrees: 126))
                    .rotationEffect(angle, anchor: .center)
                    .foregroundStyle(.white.opacity(0.5))
            } else {
                Circle()
                    .stroke(lineWidth: strokeThickness)
                    .scaleAndPlaceIndicator(in: frame, thickness: strokeThickness)
                    .rotationEffect(Angle(degrees: 126))
                    .rotationEffect(angle, anchor: .center)
            }
        }
    }
}

struct LegacyGaugeIndicator: View {
    @Environment(\.indicatorColor) private var indicatorColor
    @Environment(\.meterThickness) private var customMeterThickness
    
    let angle: Angle
    let frame: CGSize
    
    var body: some View {
        let standardMeterThickness = frame.width / 10
        let strokeThickness = (customMeterThickness ?? standardMeterThickness) / 2
        
        ZStack {
            if let indicatorColor {
                Circle()
                    .stroke(lineWidth: strokeThickness)
                    .scaleAndPlaceIndicator(in: frame, thickness: strokeThickness)
                    .rotationEffect(Angle(degrees: 126))
                    .rotationEffect(angle, anchor: .center)
                    .foregroundColor(indicatorColor)
                    .shadow(color: .black.opacity(0.2), radius: 2)
                Circle()
                    .strokeBorder(lineWidth: 1)
                    .scaleAndPlaceIndicator(in: frame, thickness: strokeThickness, stroke: true)
                    .rotationEffect(Angle(degrees: 126))
                    .rotationEffect(angle, anchor: .center)
                    .foregroundColor(.white.opacity(0.5))
            } else {
                Circle()
                    .stroke(lineWidth: strokeThickness)
                    .scaleAndPlaceIndicator(in: frame, thickness: strokeThickness)
                    .rotationEffect(Angle(degrees: 126))
                    .rotationEffect(angle, anchor: .center)
            }
        }
    }
}

private struct IndicatorPlacement: ViewModifier {
    let frame: CGSize
    let thickness: Double
    let stroke: Bool
    
    func body(content: Content) -> some View {
        content
            .frame(
                width: thickness * (stroke ? 2.75 : 1.75),
                height: thickness * (stroke ? 2.75 : 1.75)
            )
            .offset(x: (frame.width / 2) - (thickness))
    }
}

private extension View {
    func scaleAndPlaceIndicator(
        in frame: CGSize,
        thickness: Double,
        stroke: Bool = false
    ) -> some View {
        self.modifier(
            IndicatorPlacement(frame: frame, thickness: thickness, stroke: stroke)
        )
    }
}

#Preview {
    GaugeView(
        title: "Speed",
        value: 10,
        colors: [.red, .orange, .yellow, .green]
    )
}

