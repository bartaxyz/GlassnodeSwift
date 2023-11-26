//
//  APIServiceTest.swift
//  glassnode-swiftTests
//
//  Created by Ondrej Barta on 25.11.23.
//

import XCTest
@testable import GlassnodeSwift

class APIServiceTests: XCTestCase {
    var networkService: NetworkService!

    override func setUp() {
        super.setUp()
        networkService = NetworkService.shared
    }

    override func tearDown() {
        networkService = nil
        super.tearDown()
    }

    func testAPIFetchMetricData() {
        let expectation = self.expectation(description: "FetchMetricDataExpectation")

        let testURL = URL(string: APIEndpoints.metricEndpoint(metricPath: "addresses/profit_count", assetSymbol: "BTC")!)!
        
        print(testURL.absoluteString)

        // Perform the request
        Task {
            do {
                let data: MetricData = try await networkService.request(url: testURL)
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

