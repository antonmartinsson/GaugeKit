//
//  GaugeLabelStack.swift
//  GaugeLabelStack
//
//  Created by Anton Martinsson on 2021-07-30.
//

import SwiftUI

/**
 A simple vertical stack of labels to be stashed within the gauge view.
 
 - Parameters:
 - geometry: The frame of the container the label stack is contained within.
 - value: An integer between 0 and 100 displayed inside the gauge.
 -	title: A title to be displayed below the value.
 */
struct GaugeLabelStack: View {
  @Environment(\.valueLabelColor) var valueColor
  @Environment(\.titleLabelColor) var titleColor
  
  var value: Int?
  var title: String?
  
  private func smallestDimension(for geometry: GeometryProxy) -> Double {
    let isTaller = geometry.size.width < geometry.size.height
    let smallestDimension = isTaller ? geometry.size.width : geometry.size.height
    return smallestDimension
  }
  
  var body: some View {
    GeometryReader { geometry in
      VStack {
        if let unwrappedValue = value {
          Text("\(unwrappedValue)")
            .fontWeight(.bold)
            .font(.system(size: smallestDimension(for: geometry) / 4))
            .foregroundColor(valueColor)
            .lineLimit(1)
            .frame(maxWidth: geometry.size.width * 0.8)
        }
        if let unwrappedTitle = title {
          Text(unwrappedTitle)
            .fontWeight(.light)
            .font(.system(size: smallestDimension(for: geometry) / 12))
            .foregroundColor(titleColor)
            .multilineTextAlignment(.center)
            .frame(maxWidth: geometry.size.width / 2)
        }
      }
      .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
    }
    .aspectRatio(1, contentMode: .fit)
  }
}

#Preview {
  let colors: [Color] = [.red, .orange, .yellow, .green]
  return GaugeView(title: "Speed", value: 88, maxValue: 100, colors: colors)
}
