import SwiftUI

public extension View {
  func gaugeValueColor(_ color: Color) -> some View {
    modifier(ValueLabelColor(color: color))
  }
  
  func gaugeTitleColor(_ color: Color) -> some View {
    modifier(TitleLabelColor(color: color))
  }
  
  func gaugeIndicatorColor(_ color: Color) -> some View {
    modifier(IndicatorColor(color: color))
  }
  
  func gaugeBackTint(_ color: Color) -> some View {
    modifier(BackTint(color: color))
  }
}

struct ValueLabelColor: ViewModifier {
  let color: Color
  
  func body(content: Content) -> some View {
    content
      .environment(\.valueLabelColor, color)
  }
}

struct TitleLabelColor: ViewModifier {
  let color: Color
  
  func body(content: Content) -> some View {
    content
      .environment(\.titleLabelColor, color)
  }
}

struct IndicatorColor: ViewModifier {
  let color: Color
  
  func body(content: Content) -> some View {
    content
      .environment(\.indicatorColor, color)
  }
}

struct BackTint: ViewModifier {
  let color: Color
  
  func body(content: Content) -> some View {
    content
      .environment(\.backTintColor, color)
  }
}

private struct ValueLabelColorKey: EnvironmentKey {
  static let defaultValue: Color = CrossPlatform.systemLabelColor()
}

private struct TitleLabelColorKey: EnvironmentKey {
  static let defaultValue: Color = CrossPlatform.systemLabelColor()
}

private struct IndicatorColorKey: EnvironmentKey {
  static let defaultValue: Color = CrossPlatform.systemBackgroundColor()
}

private struct BackTintColorKey: EnvironmentKey {
  static let defaultValue: Color = CrossPlatform.systemLabelColor()
}

extension EnvironmentValues {
  var valueLabelColor: Color {
    get { self[ValueLabelColorKey.self] }
    set { self[ValueLabelColorKey.self] = newValue }
  }
  
  var titleLabelColor: Color {
    get { self[TitleLabelColorKey.self] }
    set { self[TitleLabelColorKey.self] = newValue }
  }
  
  var indicatorColor: Color {
    get { self[IndicatorColorKey.self] }
    set { self[IndicatorColorKey.self] = newValue }
  }
  
  var backTintColor: Color {
    get { self[BackTintColorKey.self] }
    set { self[BackTintColorKey.self] = newValue }
  }
}
