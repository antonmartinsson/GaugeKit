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
	var geometry: GeometryProxy
	var value: Int?
	var title: String?
	
	var body: some View {
		let isTaller = geometry.size.width < geometry.size.height
		let smallestDimension = isTaller ? geometry.size.width : geometry.size.height
		
		VStack {
			if let unwrappedValue = value {
				Text("\(unwrappedValue)")
					.font(.system(size: smallestDimension / 4))
					.fontWeight(.bold)
			}
			if let unwrappedTitle = title {
				Text(unwrappedTitle)
					.fontWeight(.light)
					.font(.system(size: smallestDimension / 20))
			}
		}
		.position(x: geometry.size.width / 2, y: geometry.size.height / 2)
	}
}
