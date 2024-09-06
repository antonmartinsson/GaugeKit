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
    
    func meterShadow(color: Color = .black.opacity(0.33), radius: Double, x: Double = 0, y: Double = 0) -> some View {
        modifier(MeterShadow(shadow: Shadow(color: color, radius: radius, x: x, y: y)))
    }
    
    func reverseMask<Mask: View>(alignment: Alignment = .center, @ViewBuilder _ mask: () -> Mask) -> some View {
        self.mask {
            Rectangle()
                .overlay(alignment: alignment) {
                    mask()
                        .blendMode(.destinationOut)
                }
        }
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

struct MeterShadow: ViewModifier {
    let shadow: Shadow
    
    func body(content: Content) -> some View {
        content
            .environment(\.meterShadow, shadow)
    }
}

struct Shadow {
    let color: Color
    let radius: Double
    let x: Double
    let y: Double
}

extension EnvironmentValues {
    @Entry var valueLabelColor: Color? = nil
    @Entry var titleLabelColor: Color? = nil
    @Entry var indicatorColor: Color? = nil
    @Entry var backTintColor: Color = CrossPlatform.systemLabelColor
    @Entry var meterShadow: Shadow? = nil
}
