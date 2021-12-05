import XCTest
@testable import GaugeKit

final class GaugeKitTests: XCTestCase {
	
	func testBasicInit() {
		let gauge = GaugeView(title: "A title", value: 100, colors: [.red, .green])
		XCTAssertNotNil(gauge.title)
		XCTAssertNotNil(gauge.value)
		XCTAssertEqual(gauge.title, "A title")
		XCTAssertEqual(gauge.value, 100)
		XCTAssertEqual(gauge.maxValue, 100)
		XCTAssertEqual(gauge.colors, [.red, .green])
		XCTAssertNil(gauge.additionalInfo)
	}
	
	func testMaxValueInit() {
		let gauge = GaugeView(title: "A title", value: 100, maxValue: 200, colors: [.red, .green])
		XCTAssertNotNil(gauge.title)
		XCTAssertNotNil(gauge.value)
		XCTAssertEqual(gauge.title, "A title")
		XCTAssertEqual(gauge.value, 100)
		XCTAssertEqual(gauge.maxValue, 200)
		XCTAssertEqual(gauge.colors, [.red, .green])
		XCTAssertNil(gauge.additionalInfo)
	}
	
	func testNoTitleOrValue() {
		let gauge = GaugeView(colors: [.red, .green])
		XCTAssertNil(gauge.title)
		XCTAssertNil(gauge.value)
		XCTAssertEqual(gauge.maxValue, 0)
		XCTAssertNotNil(gauge.colors)
		XCTAssertNil(gauge.additionalInfo)
	}
	
	func testNoColors() {
		let gauge = GaugeView(colors: [])
		XCTAssertNil(gauge.title)
		XCTAssertNil(gauge.value)
		XCTAssertEqual(gauge.maxValue, 0)
		XCTAssertTrue(gauge.colors.isEmpty)
		XCTAssertNil(gauge.additionalInfo)
	}
	
	func testAdditionalInfo() {
		let info = GaugeAdditionalInfo(preTitle: "This is a description", largeTitle: "Hej", body: "Blah")
		let gauge = GaugeView(title: "A title", value: 100, colors: [.red, .green], additionalInfo: info)
		XCTAssertNotNil(gauge.title)
		XCTAssertNotNil(gauge.value)
		
		XCTAssertEqual(gauge.title, "A title")
		XCTAssertEqual(gauge.value, 100)
		XCTAssertEqual(gauge.maxValue, 100)
		XCTAssertEqual(gauge.colors, [.red, .green])
		
		XCTAssertNotNil(gauge.additionalInfo?.preTitle)
		XCTAssertNotNil(gauge.additionalInfo?.largeTitle)
		XCTAssertNotNil(gauge.additionalInfo?.body)
		XCTAssertEqual(gauge.additionalInfo?.preTitle, "This is a description")
		XCTAssertEqual(gauge.additionalInfo?.largeTitle, "Hej")
		XCTAssertEqual(gauge.additionalInfo?.body, "Blah")
	}
}
