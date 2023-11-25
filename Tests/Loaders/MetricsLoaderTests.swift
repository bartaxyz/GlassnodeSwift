//
//  MetricsLoaderTests.swift
//  glassnode-swiftTests
//
//  Created by Ondrej Barta on 25.11.23.
//

import XCTest
import Combine
@testable import GlassnodeSwift // Replace with the actual name of your library

class MetricsLoaderTests: XCTestCase {
    
    var metricsLoader: GlassnodeSwift.MetricsLoader!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        metricsLoader = GlassnodeSwift.MetricsLoader()
        cancellables = []
    }

    override func tearDown() {
        metricsLoader = nil
        cancellables = nil
        super.tearDown()
    }

    func testMetricsLoadingSuccess() {
        let expectation = XCTestExpectation(description: "Metrics loaded")
        
        metricsLoader.$metrics
            .dropFirst() // Ignore the initial empty state
            .sink { metrics in
                expectation.fulfill()
            }
            .store(in: &cancellables)

        metricsLoader.fetchMetrics()
        
        wait(for: [expectation], timeout: 5.0)
    }

    func testMetricsLoadingFailure() {
        // Mock a failure scenario in fetchMetrics, and then:
        let expectation = XCTestExpectation(description: "Metrics loading failed")

        metricsLoader.$error
            .dropFirst() // Ignore the initial nil state
            .sink { error in
                if error == nil {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        metricsLoader.fetchMetrics()
        
        wait(for: [expectation], timeout: 5.0)
    }

    // Additional tests for isLoading, etc.
}
