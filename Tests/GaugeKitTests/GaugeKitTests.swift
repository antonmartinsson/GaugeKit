import XCTest
@testable import GaugeKit

@MainActor
final class GaugeKitTests: XCTestCase {
    func testTitle() {
        let gauge = GaugeView(title: "A title", value: 100, colors: [.red, .green])
        XCTAssertEqual(gauge.title, "A title")
    }
    
    func testMaxValueInit() {
        let gauge = GaugeView(title: "A title", value: 100, maxValue: 200, colors: [.red, .green])
        XCTAssertEqual(gauge.maxValue, 200)
    }
    
    func testNoTitle() {
        let gauge = GaugeView(value: 100, colors: [.red, .green])
        XCTAssertNil(gauge.title)
    }
    
    func testNoValue() {
        let gauge = GaugeView(colors: [.red, .green])
        XCTAssertNil(gauge.value)
    }
    
    func testNoColors() {
        let gauge = GaugeView(colors: [])
        XCTAssertTrue(gauge.colors.isEmpty)
    }
    
    func testNoAdditionInfo() {
        let gauge = GaugeView(colors: [])
        XCTAssertNil(gauge.additionalInfo)
    }
    
    func testAdditionalInfoTitle() {
        let info = GaugeAdditionalInfo(strap: "This is a description", title: "Hej", body: "Blah")
        let gauge = GaugeView(title: "A title", value: 100, colors: [.red, .green], additionalInfo: info)
        XCTAssertEqual(gauge.additionalInfo?.title, "Hej")
    }
    
    func testAdditionalInfoStrap() {
        let info = GaugeAdditionalInfo(strap: "This is a description", title: "Hej", body: "Blah")
        let gauge = GaugeView(title: "A title", value: 100, colors: [.red, .green], additionalInfo: info)
        XCTAssertEqual(gauge.additionalInfo?.strap, "This is a description")
    }
    
    func testAdditionalInfoBody() {
        let info = GaugeAdditionalInfo(strap: "This is a description", title: "Hej", body: "Blah")
        let gauge = GaugeView(title: "A title", value: 100, colors: [.red, .green], additionalInfo: info)
        XCTAssertEqual(gauge.additionalInfo?.body, "Blah")
    }
}
