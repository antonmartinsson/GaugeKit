import SwiftUI

public extension View {
  func gaugeValueColor(_ color: ForegroundStyle) -> some View {
    modifier(ValueLabelColor(color: color))
  }
  
  func gaugeTitleColor(_ color: ForegroundStyle) -> some View {
    modifier(TitleLabelColor(color: color))
  }
  
    func gaugeIndicatorColor(_ color: BackgroundStyle) -> some View {
    modifier(IndicatorColor(color: color))
  }
  
  func gaugeBackTint(_ color: ForegroundStyle) -> some View {
    modifier(BackTint(color: color))
  }
}

struct ValueLabelColor: ViewModifier {
  let color: ForegroundStyle
  
  func body(content: Content) -> some View {
    content
      .environment(\.valueLabelColor, color)
  }
}

struct TitleLabelColor: ViewModifier {
  let color: ForegroundStyle
  
  func body(content: Content) -> some View {
    content
      .environment(\.titleLabelColor, color)
  }
}

struct IndicatorColor: ViewModifier {
  let color: BackgroundStyle
  
  func body(content: Content) -> some View {
    content
      .environment(\.indicatorColor, color)
  }
}

struct BackTint: ViewModifier {
    let color: ForegroundStyle
  
  func body(content: Content) -> some View {
    content
      .environment(\.backTintColor, color)
  }
}

extension EnvironmentValues {
    @Entry var valueLabelColor: ForegroundStyle = .foreground
    @Entry var titleLabelColor: ForegroundStyle = .foreground
    @Entry var indicatorColor: BackgroundStyle = .background
    @Entry var backTintColor: ForegroundStyle = .foreground
}
