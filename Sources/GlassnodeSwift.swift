//
//  GlassnodeSwift.swift
//  glassnode-swift
//
//  Created by Ondrej Barta on 25.11.23.
//

import Foundation

public struct GlassnodeSwift {
    public static var configuration = Configuration()

    public struct Configuration {
        var apiKey: String?
    }
    
    public static func fetchAllMetricAssets() async throws -> MetricAssets {
        return try await StrapiService.shared.fetchAllMetricAssets()
    }
    
    public static func fetchAllMetrics() async throws -> Metrics {
        return try await StrapiService.shared.fetchAllMetrics()
    }
}
