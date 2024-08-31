//
//  CrossPlatform.swift
//  GaugeKit
//
//  Created by Matt Austin on 2022-05-27.
//

import SwiftUI

final class CrossPlatform {
    static func systemBackgroundColor() -> Color {
        #if os(macOS)
        Color(NSColor.windowBackgroundColor)
        #elseif os(iOS)
        Color(UIColor.systemBackground)
        #elseif os(visionOS)
        Color.primary
        #elseif os(watchOS)
        Color.black
        #endif
    }
    
    static func systemLabelColor() -> Color {
        #if os(macOS)
        Color(NSColor.labelColor)
        #elseif os(iOS)
        Color(.label)
        #elseif os(visionOS)
        Color(.label)
        #elseif os(watchOS)
        Color.black
        #endif
    }
}
