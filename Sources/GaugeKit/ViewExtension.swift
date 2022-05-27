//
//  ViewExtension.swift
//  CryptoCheck
//
//  Created by Anton Martinsson on 2021-06-10.
//

import SwiftUI

extension View {
   
   private func getWidgetSize(forScreenSize screenSize: CGSize, widthDivider : CGFloat, heightDivider: CGFloat) -> CGSize {
      // get the size of the main screen
      let screenSize = CrossPlatform.mainScreenSize()
      
      // return the new size
      return CGSize(width: screenSize.width / widthDivider,
                    height: screenSize.height / heightDivider)
   }
   
   /**
    Returns the size of small widgets for the screen size currently in use.
    
    - Returns: A CGSize instance representing the size of a large widget.
    */
   
   func smallWidgetSize() -> CGSize {
      let screenSize = CrossPlatform.mainScreenSize()
#if os(macOS)
      // use a constant divider since there are too many screen sizes to hardcode
      return getWidgetSize(forScreenSize: screenSize, widthDivider: 12, heightDivider: 12)
#elseif os(iOS)
      switch screenSize {
         case CGSize(width: 414, height: 896):
            return CGSize(width: 169, height: 169)
         case CGSize(width: 375, height: 812):
            return CGSize(width: 155, height: 155)
         case CGSize(width: 414, height: 736):
            return CGSize(width: 159, height: 159)
         case CGSize(width: 375, height: 667):
            return CGSize(width: 148, height: 148)
         case CGSize(width: 320, height: 568):
            return CGSize(width: 141, height: 141)
         default:
            return CGSize(width: 155, height: 155)
      }
#endif
   }
   
   /**
    Returns the size of medium widgets for the screen size currently in use..
    
    - Returns: A CGSize instance representing the size of a small widget.
    */
   
   
   func mediumWidgetSize() -> CGSize {
      let screenSize = CrossPlatform.mainScreenSize()
#if os(macOS)
      // use a constant divider since there are too many screen sizes to hardcode
      return getWidgetSize(forScreenSize: screenSize, widthDivider: 10, heightDivider: 10)
#elseif os(iOS)
      switch screenSize {
         case CGSize(width: 414, height: 896):
            return CGSize(width: 360, height: 169)
         case CGSize(width: 375, height: 812):
            return CGSize(width: 329, height: 155)
         case CGSize(width: 414, height: 736):
            return CGSize(width: 348, height: 159)
         case CGSize(width: 375, height: 667):
            return CGSize(width: 321, height: 148)
         case CGSize(width: 320, height: 568):
            return CGSize(width: 292, height: 141)
         default:
            return CGSize(width: 360, height: 155)
      }
#endif
   }
   
   /**
    Returns the size of large widgets for the screen size currently in use.
    
    - Returns: A CGSize instance representing the size of a large widget.
    */
   
   func largeWidgetSize() -> CGSize {
      let screenSize = CrossPlatform.mainScreenSize()
#if os(macOS)
      // use a constant divider since there are too many screen sizes to hardcode
      return getWidgetSize(forScreenSize: screenSize, widthDivider: 8, heightDivider: 8)
#elseif os(iOS)
      switch screenSize {
         case CGSize(width: 414, height: 896):
            return CGSize(width: 360, height: 379)
         case CGSize(width: 375, height: 812):
            return CGSize(width: 329, height: 345)
         case CGSize(width: 414, height: 736):
            return CGSize(width: 348, height: 357)
         case CGSize(width: 375, height: 667):
            return CGSize(width: 321, height: 324)
         case CGSize(width: 320, height: 568):
            return CGSize(width: 292, height: 311)
         default:
            return CGSize(width: 360, height: 379)
      }
#endif
   }
   
   func widgetify() -> some View {
      self.modifier(RoundCornersAndAddShadows())
   }
}

struct RoundCornersAndAddShadows: ViewModifier {
   func body(content: Content) -> some View {
      content
         .cornerRadius(30)
         .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 0)
   }
}

