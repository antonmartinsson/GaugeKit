import SwiftUI

@MainActor
public extension View {
    @available(*, deprecated, message: "Use a regular .foregroundStyle modifier instead")
    func gaugeValueColor(_ color: Color) -> some View {
        environment(\.valueLabelColor, color)
    }
    
    @available(*, deprecated, message: "Use a regular .foregroundStyle modifier instead")
    func gaugeTitleColor(_ color: Color) -> some View {
        environment(\.titleLabelColor, color)
    }
    
    func gaugeIndicatorColor(_ color: Color) -> some View {
        environment(\.indicatorColor, color)
    }
    
    func gaugeBackTint(_ color: Color) -> some View {
        environment(\.backTintColor, color)
    }
    
    func gaugeMeterShadow(color: Color = .black.opacity(0.33), radius: Double, x: Double = 0, y: Double = 0) -> some View {
        environment(\.meterShadow, Shadow(color: color, radius: radius, x: x, y: y))
    }
    
    func gaugeMeterThickness(_ thickness: Double) -> some View {
        environment(\.meterThickness, thickness)
    }
    
    func labelStackHidden() -> some View {
        environment(\.labelsHidden, true)
    }
    
    @available(iOS 15.0, macOS 12.0, watchOS 8.0, *)
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
    @Entry var meterThickness: Double? = nil
    @Entry var labelsHidden: Bool = false
}
