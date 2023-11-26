//
//  StrapiService.swift
//  glassnode-swift
//
//  Created by Ondrej Barta on 25.11.23.
//

import Foundation

public class StrapiService {
    static let shared = StrapiService()

    public init() {}
    
    public func fetchAllMetricAssets() async throws -> MetricAssets {
        let url = URL(string: StrapiEndpoints.allMetricAssets)!
        return try await NetworkService.shared.request(url: url)
    }

    public func fetchAllMetrics() async throws -> Metrics {
        let url = URL(string: StrapiEndpoints.allMetrics)!
        return try await NetworkService.shared.request(url: url)
    }
}
