//
//  GaugeView.swift
//  CryptoCheck
//
//  Created by Anton Martinsson on 2021-06-19.
//
//  A Gauge similar to the gauges used for some Apple Watch complication.

import SwiftUI

/**
 A view ideal for visualizing a value between 0 and 100 in a gauge,
 not too different from the native gauges used by Apple for some Apple Watch complications.
 
 - Parameters:
		- title: A decriptive string value to display inside the gauge.
		- value: An integer between 0 and 100 displayed inside the gauge, which also determines the position of the gauge's indicator.
		- colors: The colors that should be used in the gradient that wipes across the gauge.
		- additionalInfo: A struct containing three (optional) strings to display when the user taps on the gauge.
 */
public struct GaugeView : View {
	@State private var flipped: Bool = false
	
	var title: String?
	var value: Int?
	var colors: [Color]
	var additionalInfo: GaugeAdditionalInfo?
	
	var body: some View {
		ZStack {
			ZStack {
				GaugeMeter(value: value, colors: colors)
				GeometryReader { geometry in
					GaugeLabelStack(containerSize: geometry.size, value: value, title: title)
						.position(x: geometry.size.width / 2, y: geometry.size.height / 2)
				}
			}
			.rotation3DEffect(Angle(degrees: flipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
			.opacity(flipped ? 0.1 : 1)
			
			if let info = additionalInfo {
				GaugeBackView(flipped: $flipped, additionalInfo: info)
			}
		}
		
		.if(additionalInfo != nil) { content in
			content.onTapGesture {
				withAnimation {
					self.flipped.toggle()
				}
			}
		}
	}
}

struct Gauge_Previews: PreviewProvider {
	static var previews: some View {
		GaugeView(title: "BTC F&G",
							value: 50,
							colors: [.red, .orange, .yellow, .green])
	}
}
