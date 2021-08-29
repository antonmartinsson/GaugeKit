//
//  GaugeBackView.swift
//  GaugeBackView
//
//  Created by Anton Martinsson on 2021-07-30.
//

import SwiftUI

struct GaugeAdditionalInfo {
	let description: String?
	let title: String?
	let body: String?
}

/**
 If additional info is provided to the gauge, this view will be revealed with a flip animation when the user taps on the gauge.
 
 - Parameters:
		- flipped: A binding of a boolean that determines whether or not the gauge is "flipped over".
		- additionalInfo: The info to display within the view.
 */
struct GaugeBackView: View {
	@Binding var flipped: Bool
	var additionalInfo: GaugeAdditionalInfo
	
	var body: some View {
		GeometryReader { geometry in
			VStack {
				if let description = additionalInfo.description {
					Text(description)
				}
				if let title = additionalInfo.title {
					Text(title)
						.font(.system(size: geometry.size.width / 5, weight: .bold))
						.padding(.bottom, 4)
				}
				if let body = additionalInfo.body {
					Text(body)
				}
			}
			.position(x: geometry.size.width / 2, y: geometry.size.height / 2)
		}
		.opacity(flipped ? 1 : 0)
		.rotation3DEffect(Angle(degrees: flipped ? -180 : 0), axis: (x: 0, y: 1, z: 0))
		.rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 1, z: 0))
	}
}


struct GaugeBackView_Previews: PreviewProvider {
    static var previews: some View {
			let info = GaugeAdditionalInfo(description: "Hejsan",
																		 title: "Svejsan",
																		 body: "Hörru")
			
			GaugeBackView(flipped: .constant(true),
										additionalInfo: info)
    }
}
