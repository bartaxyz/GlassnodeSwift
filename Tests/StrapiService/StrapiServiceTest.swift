//
//  StrapiServiceTest.swift
//  glassnode-swiftTests
//
//  Created by Ondrej Barta on 25.11.23.
//

import XCTest
@testable import GlassnodeSwift

class StrapiServiceTests: XCTestCase {
    var networkService: NetworkService!

    override func setUp() {
        super.setUp()
        networkService = NetworkService.shared
    }

    override func tearDown() {
        networkService = nil
        super.tearDown()
    }

    func testStrapiFetchAllMetrics() {
        let expectation = self.expectation(description: "FetchAllMetricsExpectation")

        let testURL = URL(string: StrapiEndpoints.allMetrics)!

        // Perform the request
        Task {
            do {
                let data: Metrics = try await networkService.request(url: testURL)
                // Validate the results
                XCTAssertNotNil(data)
                expectation.fulfill()
            } catch {
                XCTFail("Request failed with error: \(error)")
            }
        }

        waitForExpectations(timeout: 5) // Adjust timeout as needed
    }
}
