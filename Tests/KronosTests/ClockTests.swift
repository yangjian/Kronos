import XCTest
@testable import Kronos

final class ClockTests: XCTestCase {

    override func setUp() {
        super.setUp()
        Clock.reset()
    }

    func testFirst() {
        let expectation = self.expectation(description: "Clock sync calls first closure")
        Clock.sync(first: { date, offset, delay in
            XCTAssertNotNil(date)
            expectation.fulfill()
        })

        self.waitForExpectations(timeout: 2)
    }

    func testLast() {
        let expectation = self.expectation(description: "Clock sync calls last closure")
        Clock.sync(completion: { date, offset, delay in
            XCTAssertNotNil(date)
            XCTAssertNotNil(offset)
            expectation.fulfill()
        })

        self.waitForExpectations(timeout: 20)
    }

    func testBoth() {
        let firstExpectation = self.expectation(description: "Clock sync calls first closure")
        let lastExpectation = self.expectation(description: "Clock sync calls last closure")
        Clock.sync(
            first: { _, _, _ in firstExpectation.fulfill() },
            completion: { _, _, _ in lastExpectation.fulfill() })

        self.waitForExpectations(timeout: 20)
    }
}
