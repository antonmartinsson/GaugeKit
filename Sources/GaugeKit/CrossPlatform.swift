//
//  CrossPlatform.swift
//  GaugeKit
//
//  Created by Matt Austin on 2022-05-27.
//

import SwiftUI

class CrossPlatform {
  static func mainScreenSize() -> CGSize {
#if os(macOS)
    if let screenSize = NSScreen.main?.frame.size {
      return screenSize
    }
    else {
      // Use a generic FHD size so any calculations will still work
      return CGSize(width: 1920, height: 1080)
    }
#elseif os(iOS)
    return UIScreen.main.bounds.size
#elseif os(watchOS)
    return WKInterfaceDevice.current().screenBounds.size
#endif
  }
  
  static func systemBackgroundColor() -> Color {
#if os(macOS)
    Color(NSColor.windowBackgroundColor)
#elseif os(iOS)
    Color(UIColor.systemBackground)
#elseif os(watchOS)
    Color.black
#endif
  }
  
  static func systemLabelColor() -> Color {
#if os(macOS)
    Color(NSColor.labelColor)
#elseif os(iOS)
    Color(UIColor.label)
#elseif os(watchOS)
    Color.black
#endif
  }
}

