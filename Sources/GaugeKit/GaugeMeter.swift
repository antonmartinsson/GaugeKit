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
 */

struct GaugeMeter : View {
	var value: Int?
	var colors: [Color]
	
	let trimStart = 0.1
	let trimEnd = 0.9
	
	var body: some View {
		let startAngle = 360 * trimStart
		let endAngle = 360 * trimEnd
		
		ZStack {
			GeometryReader { geometry in
				let meterThickness = geometry.size.width / 10
				let gradient = Gradient(colors: colors)
				
				AngularGradient(gradient: gradient,
												center: .center,
												startAngle: .degrees(startAngle),
												endAngle: .degrees(endAngle))
					.mask(
						GaugeMask(trimStart: trimStart,
											trimEnd: trimEnd,
											meterThickness: Double(meterThickness))
					)
					.rotationEffect(Angle(degrees: 90))
					.position(x: geometry.size.width / 2, y: geometry.size.height / 2)
					.shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 0)
				
				
				if let unwrappedValue = value {
					let degrees = (Double(unwrappedValue) * 2.88)
					GaugeIndicator(angle: Angle(degrees: degrees), size: geometry.size)
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
	var trimStart: Double
	var trimEnd: Double
	var meterThickness: Double
	
	var body: some View {
		Circle()
			.trim(from: CGFloat(trimStart), to: CGFloat(trimEnd))
			.stroke(style: StrokeStyle(lineWidth: CGFloat(meterThickness),
																 lineCap: .round))
			.padding(CGFloat(meterThickness))
	}
}

struct GaugeComponents_Previews: PreviewProvider {
	static var previews: some View {
		Gauge(title: "BTC F&G",
							value: 50,
							colors: [.red, .orange, .yellow, .green])
	}
}
