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
	var angle: Angle?
	var size: CGSize
	
	var body: some View {
		let lineWidth = size.width / 20
		
		if let placement = angle {
			Circle()
				.stroke(lineWidth: lineWidth)
                .foregroundColor(CrossPlatform.systemBackgroundColor())
				.scaleAndPlaceIndicator(withGaugeSize: size)
				.rotationEffect(Angle(degrees: 126))
				.rotationEffect(placement, anchor: .center)
		}
	}
}

/**
 A custom ViewModifier mainly created to declutter the amount of attributes on the indicator slightly.
 
 - Parameters:
		- size: The size of the gauge being displayed.
 */
private struct IndicatorPlacement: ViewModifier {
	var size: CGSize
	
	func body(content: Content) -> some View {
		content
			.padding(size.width / 5)
			.frame(width: size.width / 2, height: size.height / 2)
			.position(x: size.width / 2, y: size.height / 2)
			.offset(x: size.width / 2.5)
	}
}

private extension View {
	func scaleAndPlaceIndicator(withGaugeSize gaugeSize: CGSize) -> some View {
		self.modifier(IndicatorPlacement(size: gaugeSize))
	}
}

struct GaugeIndicator_Previews: PreviewProvider {
	static var previews: some View {
		GaugeView(title: "Speed",
					value: 88,
					colors: [.red, .orange, .yellow, .green])
			.padding()
	}
}

