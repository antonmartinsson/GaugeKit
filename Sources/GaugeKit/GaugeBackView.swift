//
//  GaugeBackView.swift
//  GaugeBackView
//
//  Created by Anton Martinsson on 2021-07-30.
//

import SwiftUI

public struct GaugeAdditionalInfo {
  public let strap: String?
  public let title: String?
  public let body: String?
  
  init(strap: String?, title: String?, body: String?) {
    self.strap = strap
    self.title = title
    self.body = body
  }
  
  @available(*, deprecated, message: "Use init(strap:title:body:) instead")
  init(preTitle: String?, largeTitle: String?, body: String?) {
    self.strap = preTitle
    self.title = largeTitle
    self.body = body
  }
}

/**
 If additional info is provided to the gauge, this view will be revealed with a flip animation when the user taps on the gauge.
 
 - Parameters:
 - flipped: A binding of a boolean that determines whether or not the gauge is "flipped over".
 - additionalInfo: The info to display within the view.
 */
struct GaugeBackView: View {
  @Environment(\.backTintColor) var backTintStyle
  
  @Binding var flipped: Bool
  let additionalInfo: GaugeAdditionalInfo
  
  private var flipAngle: Angle {
    Angle(degrees: flipped ? -180 : 0)
  }
  
  var body: some View {
    GeometryReader { geometry in
      VStack {
        if let preTitle = additionalInfo.strap {
          Text(preTitle)
            .font(.system(size: geometry.size.width / 20, weight: .regular))
        }
        if let title = additionalInfo.title {
          Text(title)
            .font(.system(size: geometry.size.width / 5, weight: .bold))
            .padding(.bottom, 4)
        }
        if let body = additionalInfo.body {
          Text(body)
            .font(.system(size: geometry.size.width / 20, weight: .regular))
        }
      }
      .foregroundStyle(backTintStyle)
      .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
    }
    .opacity(flipped ? 1 : 0)
    .rotation3DEffect(flipAngle, axis: (x: 0, y: 1, z: 0))
    .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 1, z: 0))
  }
}


#Preview {
    GaugeBackView(
        flipped: .constant(true),
        additionalInfo: GaugeAdditionalInfo(
            strap: "Hejsan",
            title: "Svejsan",
            body: "Hörru"
        )
    )
}
