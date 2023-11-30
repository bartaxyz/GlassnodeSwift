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
    
    static func getSinceUntilQueryItems(since: Date, until: Date) -> [URLQueryItem] {
        var queryItems = getSinceUntilQueryItems(since: since)
        let untilTimestamp = Int(until.timeIntervalSince1970)
        queryItems.append(URLQueryItem(name: "u", value: String(untilTimestamp)))
        return queryItems
    }
    
    static func getSinceUntilQueryItems(since: Date) -> [URLQueryItem] {
        let sinceTimestamp = Int(since.timeIntervalSince1970)
        return [
            URLQueryItem(name: "s", value: String(sinceTimestamp))
        ]
    }
    
    static func dataForLastMonthsQueryItems(monthCount: Int = 3) -> [URLQueryItem] {
        let now = Date()
        let since = Calendar.current.date(
            byAdding: .month,
            value: -monthCount,
            to: now
        )!
        return getSinceUntilQueryItems(since: since)
    }
    
    static func metricEndpoint(metricPath: String, assetSymbol: String) -> String? {
        var components = URLComponents(string: base)
        components?.path = baseMetric + "/" + metricPath
        components?.queryItems = [
            URLQueryItem(name: "a", value: assetSymbol),
            URLQueryItem(name: "api_key", value: GlassnodeSwift.configuration.apiKey)
        ] + dataForLastMonthsQueryItems()
        
        return components?.url?.absoluteString
    }
}
