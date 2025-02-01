import Foundation

extension Double {
    func string(withMaxNumberOfDecimals decimals: Int, minNumberOfDecimals: Int = 0) -> String {
        let shouldForceTwoDecimals = self < 1 && decimals < 2

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        formatter.maximumFractionDigits = shouldForceTwoDecimals ? 2 : decimals
        formatter.minimumFractionDigits = minNumberOfDecimals

        guard let formattedString = formatter.string(from: NSNumber(value: self)) else {
            return String(self)
        }
        return formattedString
    }
}
