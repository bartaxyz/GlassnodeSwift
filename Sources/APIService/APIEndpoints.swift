//
//  APIEndpoints.swift
//
//
//  Created by Ondrej Barta on 26.11.23.
//

import Foundation

struct APIEndpoints {
    static let base = "https://api.glassnode.com"
    static let baseMetric = "/v1/metrics"
    
    static func dataForLast7DaysQueryItems() -> [URLQueryItem] {
        let now = Date()
        let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: now)!

        let sinceTimestamp = Int(sevenDaysAgo.timeIntervalSince1970)
        let untilTimestamp = Int(now.timeIntervalSince1970)

        return [
            URLQueryItem(name: "s", value: String(sinceTimestamp)),
            // URLQueryItem(name: "u", value: String(untilTimestamp))
        ]
    }
    
    static func metricEndpoint(metricPath: String, assetSymbol: String) -> String? {
        var components = URLComponents(string: base)
        components?.path = baseMetric + "/" + metricPath
        components?.queryItems = [
            URLQueryItem(name: "a", value: assetSymbol),
            URLQueryItem(name: "api_key", value: GlassnodeSwift.configuration.apiKey)
        ] + dataForLast7DaysQueryItems()
        
        return components?.url?.absoluteString
    }
}
