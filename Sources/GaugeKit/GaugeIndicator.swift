//
//  GaugeIndicator.swift
//  GaugeIndicator
//
//  Created by Anton Martinsson on 2021-07-30.
//

import SwiftUI

/**
 The small circular indicator placed on top of the gauge to visualize it's current value.
 
 - Parameters:
 - angle: The angle at which to place the indicator on top of the gauge.
 - size: The size of the gauge being displayed.
 */
struct GaugeIndicator: View {
  @Environment(\.indicatorColor) var color
  
  var angle: Angle?
  var size: CGSize
  
  var body: some View {
    let lineWidth = size.width / 20
    
    if let placement = angle {
      ZStack {
        Circle()
          .stroke(lineWidth: lineWidth)
          .scaleAndPlaceIndicator(withGaugeSize: size)
          .rotationEffect(Angle(degrees: 126))
          .rotationEffect(placement, anchor: .center)
          .foregroundColor(color)
          .shadow(color: .black.opacity(0.2), radius: 2)
        Circle()
          .strokeBorder(lineWidth: 1)
          .scaleAndPlaceIndicator(withGaugeSize: size, stroke: true)
          .rotationEffect(Angle(degrees: 126))
          .rotationEffect(placement, anchor: .center)
          .foregroundColor(.white.opacity(0.5))
      }
    }
  }
}

/**
 A custom ViewModifier mainly created to declutter the amount of attributes on the indicator slightly.
 
 - Parameters:
  - size: The size of the gauge being displayed.
  - stroke: Whether or not the view the modifier is being applied to is the stroke on the outside of the indicator.
 */
private struct IndicatorPlacement: ViewModifier {
  let size: CGSize
  let stroke: Bool
  
  func body(content: Content) -> some View {
    content
      .padding(stroke ? size.width / 5.72 : size.width / 5)
      .frame(width: size.width / 2, height: size.height / 2)
      .position(x: size.width / 2, y: size.height / 2)
      .offset(x: size.width / 2.5)
  }
}

private extension View {
  func scaleAndPlaceIndicator(withGaugeSize gaugeSize: CGSize, stroke: Bool = false) -> some View {
    self.modifier(IndicatorPlacement(size: gaugeSize, stroke: stroke))
  }
}

struct GaugeIndicator_Previews: PreviewProvider {
  static var previews: some View {
    GaugeView(
      title: "Speed",
      value: 10,
      colors: [.red, .orange, .yellow, .green]
    )
    .preferredColorScheme(.light)
    .padding()
  }
}

