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
    - title: A title to be displayed below the value.
 */
struct GaugeLabelStack: View {
    @Environment(\.valueLabelColor) var valueStyle
    @Environment(\.titleLabelColor) var titleStyle
    
    let value: Int?
    let title: String?
    
    private func smallestDimension(for geometry: GeometryProxy) -> Double {
        let isTaller = geometry.size.width < geometry.size.height
        let smallestDimension = isTaller ? geometry.size.width : geometry.size.height
        return smallestDimension
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if let value, let valueStyle {
                    ValueView(
                        value: value,
                        fontSize: smallestDimension(for: geometry) / 4
                    )
                    .foregroundStyle(valueStyle)
                    .frame(maxWidth: geometry.size.width * 0.8)
                } else if let value {
                    ValueView(
                        value: value,
                        fontSize: smallestDimension(for: geometry) / 4
                    )
                    .frame(maxWidth: geometry.size.width * 0.8)
                }
                if let title, let titleStyle {
                    TitleView(
                        string: title,
                        fontSize: smallestDimension(for: geometry) / 12
                    )
                    .foregroundStyle(titleStyle)
                    .frame(maxWidth: geometry.size.width / 2)
                } else if let title {
                    TitleView(
                        string: title,
                        fontSize: smallestDimension(for: geometry) / 12
                    )
                    .frame(maxWidth: geometry.size.width / 2)
                }
            }
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    private struct ValueView: View {
        let value: Int
        let fontSize: Double
        
        var body: some View {
            #if os(visionOS)
            Text("\(value)")
              .fontWeight(.bold)
              .font(.system(size: fontSize))
              .lineLimit(1)
            #else
            if #available(iOS 16.0, macOS 13.0, watchOS 9.0, *) {
                Text("\(value)")
                  .fontWeight(.bold)
                  .font(.system(size: fontSize))
                  .lineLimit(1)
                  .widgetAccentable()
            } else {
                Text("\(value)")
                  .fontWeight(.bold)
                  .font(.system(size: fontSize))
                  .lineLimit(1)
            }
            #endif
        }
    }
    
    private struct TitleView: View {
        let string: String
        let fontSize: Double
        
        var body: some View {
            #if os(visionOS)
            Text(string)
                .fontWeight(.light)
                .font(.system(size: fontSize))
                .multilineTextAlignment(.center)
            #else
            if #available(iOS 16.0, macOS 13.0, watchOS 9.0, *) {
                Text(string)
                    .fontWeight(.light)
                    .font(.system(size: fontSize))
                    .multilineTextAlignment(.center)
                    .widgetAccentable()
            } else {
                Text(string)
                    .fontWeight(.light)
                    .font(.system(size: fontSize))
                    .multilineTextAlignment(.center)
            }
            #endif
        }
    }
}

#Preview {
    let colors: [Color] = [.red, .orange, .yellow, .green]
    return GaugeView(title: "Speed", value: 88, maxValue: 100, colors: colors)
}
