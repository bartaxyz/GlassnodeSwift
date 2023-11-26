//
//  APIService.swift
//  GlassnodeSwift
//
//  Created by Ondrej Barta on 25.11.23.
//

import Foundation

extension GlassnodeSwift {
    public class APIService {
        public static func fetchMetricData(metricPath: String, assetSymbol: String) async throws -> MetricData {
            let url = URL(string: APIEndpoints.metricEndpoint(metricPath: metricPath, assetSymbol: assetSymbol)!)!
            return try await NetworkService.shared.request(url: url)
        }
    }
}
