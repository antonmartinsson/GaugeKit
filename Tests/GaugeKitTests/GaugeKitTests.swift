import XCTest
@testable import GaugeKit

final class GaugeKitTests: XCTestCase {
	
	func testBasicInit() {
		let gauge = Gauge(title: "A title", value: 100, colors: [.red, .green])
		XCTAssertNotNil(gauge.title)
		XCTAssertNotNil(gauge.value)
		XCTAssertEqual(gauge.title, "A title")
		XCTAssertEqual(gauge.value, 100)
		XCTAssertEqual(gauge.colors, [.red, .green])
	}
	
	func testNoTitleOrValue() {
		let gauge = Gauge(colors: [.red, .green])
		XCTAssertNil(gauge.title)
		XCTAssertNil(gauge.value)
		XCTAssertNotNil(gauge.colors)
	}
	
	func testNoColors() {
		let gauge = Gauge(colors: [])
		XCTAssertNil(gauge.title)
		XCTAssertNil(gauge.value)
		XCTAssertTrue(gauge.colors.isEmpty)
	}
	
	func testAdditionalInfo() {
		let info = GaugeAdditionalInfo(preTitle: "This is a description", largeTitle: "Hej", body: "Blah")
		let gauge = Gauge(title: "A title", value: 100, colors: [.red, .green], additionalInfo: info)
		XCTAssertNotNil(gauge.title)
		XCTAssertNotNil(gauge.value)
		
		XCTAssertEqual(gauge.title, "A title")
		XCTAssertEqual(gauge.value, 100)
		XCTAssertEqual(gauge.colors, [.red, .green])
		
		XCTAssertNotNil(gauge.additionalInfo?.preTitle)
		XCTAssertNotNil(gauge.additionalInfo?.largeTitle)
		XCTAssertNotNil(gauge.additionalInfo?.body)
		XCTAssertEqual(gauge.additionalInfo?.preTitle, "This is a description")
		XCTAssertEqual(gauge.additionalInfo?.largeTitle, "Hej")
		XCTAssertEqual(gauge.additionalInfo?.body, "Blah")
	}
}
