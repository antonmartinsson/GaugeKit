import SwiftUI

public extension View {
    @available(*, deprecated, message: "Use a regular .foregroundStyle modifier instead")
    func gaugeValueColor(_ color: Color) -> some View {
        modifier(ValueLabelColor(color: color))
    }
    
    @available(*, deprecated, message: "Use a regular .foregroundStyle modifier instead")
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

extension EnvironmentValues {
    @Entry var valueLabelColor: Color? = nil
    @Entry var titleLabelColor: Color? = nil
    @Entry var indicatorColor: Color = CrossPlatform.systemBackgroundColor()
    @Entry var backTintColor: Color = CrossPlatform.systemLabelColor()
}
