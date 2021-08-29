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
		- containerSize: The size of the gauge, as provided by a GeometryReader instance in Gauge.
		- value: An integer between 0 and 100 displayed inside the gauge.
		-	title: A title to be displayed below the value.
 */
struct GaugeLabelStack: View {
	var containerSize: CGSize
	var value: Int?
	var title: String?
	
	var body: some View {
		let isTaller = containerSize.width < containerSize.height
		let smallestDimension = isTaller ? containerSize.width : containerSize.height
		
		VStack {
			if let unwrappedValue = value {
				Text("\(unwrappedValue)")
					.font(.system(size: smallestDimension / 4))
					.fontWeight(.bold)
			} else {
				Text("--")
					.font(.system(size: smallestDimension / 4))
					.fontWeight(.bold)
			}
			if let unwrappedTitle = title {
				Text(unwrappedTitle)
					.fontWeight(.light)
					.font(.system(size: smallestDimension / 20))
			}
		}
	}
}

struct GaugeLabelStack_Previews: PreviewProvider {
    static var previews: some View {
        GaugeLabelStack(containerSize: CGSize(width: 500, height: 500), value: 50, title: "Neutral")
    }
}
