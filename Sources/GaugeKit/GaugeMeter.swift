//
//  GaugeMeter.swift
//  GaugeComponents
//
//  Created by Anton Martinsson on 2021-07-30.
//

import SwiftUI

/**
 The circular meter of the gauge view.
 
 - Parameters:
 - value: An integer between 0 and 100 displayed inside the gauge, which also determines the position of the gauge's indicator.
 - colors: The colors that should be used in the gradient that wipes across the gauge.
 - maxValue: The value the gauge should top out at.
 */

struct GaugeMeter : View {
  let value: Int?
  let colors: [Color]
  let maxValue: Int?
  
  private let trimStart = 0.1
  private let trimEnd = 0.9
  
  init(value: Int? = nil, maxValue: Int? = nil, colors: [Color]) {
    self.colors = colors
    self.value = value
    let defaultMaxValue = maxValue == nil && value != nil
    self.maxValue = defaultMaxValue ? 100 : maxValue
  }
  
  private var startAngle: Double {
    360 * trimStart
  }
  
  private var endAngle: Double {
    360 * trimEnd
  }
  
  private var gradient: Gradient {
    Gradient(colors: colors)
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

  private func meterThickness(for geometry: GeometryProxy) -> Double {
    (geometry.size.width / 10)
  }
  
  var body: some View {
    ZStack {
      GeometryReader { geometry in
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
        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 0)
        
        if let indicatorAngle {
          GaugeIndicator(angle: indicatorAngle, size: geometry.size)
        }
      }
    }
    .aspectRatio(1, contentMode: .fit)
  }
}

/** A circular view used as a mask over the angular gradient of the GaugeMeter.
 
 - Parameters:
 - trimStart: A double between 0 and 1 that determines where the meter should begin.
 - trimEnd: A double between 0 and 1 that determines where the meter should end.
 - meterThickness: The thickness of the gauge meter.
 */
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
