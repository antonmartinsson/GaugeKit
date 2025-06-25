//
//  GaugeMeter.swift
//  GaugeComponents
//
//  Created by Anton Martinsson on 2021-07-30.
//

import SwiftUI
#if !os(visionOS)
import WidgetKit
#endif

struct GaugeMeter : View {
    @Environment(\.meterShadow) private var shadow
    @Environment(\.indicatorColor) private var indicatorColor
    
    let value: Double?
    let colors: [Color]
    let maxValue: Double?
    
    init(value: Int? = nil, maxValue: Int? = nil, colors: [Color]) {
        self.value = value.map(Double.init)
        let defaultMax = (value != nil && maxValue == nil)
        self.maxValue = defaultMax ? 100 : maxValue.map(Double.init)
        self.colors = colors
    }
    
    init(value: Double? = nil, maxValue: Double? = nil, colors: [Color]) {
        self.value = value
        let defaultMax = (value != nil && maxValue == nil)
        self.maxValue = defaultMax ? 100 : maxValue
        self.colors = colors
    }
    
    private var indicatorAngle: Angle? {
        if let value, let maxValue {
            let oneUnit = (Double(360) * 0.8) / Double(maxValue)
            let degrees = (Double(value) * oneUnit)
            return Angle(degrees: degrees > (360 * 0.8) ? 360 * 0.8 : degrees)
        } else if let value {
            let oneUnit = (Double(360) * 0.8) / Double(100)
            let degrees = (Double(value) * oneUnit)
            return Angle(degrees: degrees > (360 * 0.8) ? 360 * 0.8 : degrees)
        } else {
            return nil
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            #if os(visionOS)
            MeterGradient(colors: colors, geometry: geometry)
                .overlay {
                    if let indicatorAngle {
                        GaugeIndicator(angle: indicatorAngle, frame: geometry.size)
                    }
                }
            #else
            if #available(iOS 16.0, macOS 13.0, watchOS 9.0, *), indicatorColor != nil {
                MeterGradient(colors: colors, geometry: geometry)
                    .overlay {
                        if let indicatorAngle {
                            GaugeIndicator(angle: indicatorAngle, frame: geometry.size)
                        }
                    }
            } else if #available(iOS 16.0, macOS 13.0, watchOS 9.0, *) {
                MeterGradient(colors: colors, geometry: geometry)
                    .reverseMask {
                        if let indicatorAngle {
                            GaugeIndicator(angle: indicatorAngle, frame: geometry.size)
                        }
                    }
            } else if indicatorColor != nil {
                if let indicatorAngle {
                    LegacyMeterGradient(colors: colors, geometry: geometry)
                        .overlay(
                            LegacyGaugeIndicator(angle: indicatorAngle, frame: geometry.size)
                        )
                } else {
                    LegacyMeterGradient(colors: colors, geometry: geometry)
                }
            } else {
                LegacyMeterGradient(colors: colors, geometry: geometry)
            }
            #endif
        }
        .aspectRatio(1, contentMode: .fit)
        .shadow(
            color: shadow?.color ?? .clear,
            radius: shadow?.radius ?? 0,
            x: shadow?.x ?? 0,
            y: shadow?.y ?? 0
        )
    }
    
    @available(iOS 16.0, macOS 13.0, watchOS 9.0, *)
    private struct MeterGradient: View {
        @Environment(\.meterThickness) private var thickness
        
        let colors: [Color]
        let geometry: GeometryProxy
        
        private let trimStart = 0.1
        private let trimEnd = 0.9
        
        private var gradient: Gradient {
            Gradient(colors: colors)
        }
        
        private var startAngle: Double {
            360 * trimStart
        }
        
        private var endAngle: Double {
            360 * trimEnd
        }
        
        private func meterThickness(for geometry: GeometryProxy) -> Double {
            thickness ?? (geometry.size.width / 10)
        }
        
        var body: some View {
            AngularGradient(
                gradient: gradient,
                center: .center,
                startAngle: .degrees(startAngle),
                endAngle: .degrees(endAngle)
            )
            #if !os(visionOS)
            .widgetAccentable()
            #endif
            .mask(
                GaugeMask(
                    trimStart: trimStart,
                    trimEnd: trimEnd,
                    meterThickness: meterThickness(for: geometry)
                )
            )
            .rotationEffect(Angle(degrees: 90))
        }
    }
    
    private struct LegacyMeterGradient: View {
        @Environment(\.meterThickness) private var thickness
        
        let colors: [Color]
        let geometry: GeometryProxy
        
        private let trimStart = 0.1
        private let trimEnd = 0.9
        
        private var gradient: Gradient {
            Gradient(colors: colors)
        }
        
        private var startAngle: Double {
            360 * trimStart
        }
        
        private var endAngle: Double {
            360 * trimEnd
        }
        
        private func meterThickness(for geometry: GeometryProxy) -> Double {
            thickness ?? (geometry.size.width / 10)
        }
        
        var body: some View {
            AngularGradient(
                gradient: gradient,
                center: .center,
                startAngle: .degrees(startAngle),
                endAngle: .degrees(endAngle)
            )
            .mask(
                GaugeMask(
                    trimStart: trimStart,
                    trimEnd: trimEnd,
                    meterThickness: meterThickness(for: geometry)
                )
            )
            .rotationEffect(Angle(degrees: 90))
        }
    }
}

private struct GaugeMask: View {
    let trimStart: Double
    let trimEnd: Double
    let meterThickness: Double
    
    var body: some View {
        Circle()
            .trim(from: CGFloat(trimStart), to: CGFloat(trimEnd))
            .stroke(style: StrokeStyle(
                lineWidth: CGFloat(meterThickness),
                lineCap: .round)
            )
            .padding(CGFloat(meterThickness/2))
    }
}

#Preview {
    let colors: [Color] = [.red, .orange, .yellow, .green]
    return GaugeView(title: "Speed", value: 88, maxValue: 100, colors: colors)
}
