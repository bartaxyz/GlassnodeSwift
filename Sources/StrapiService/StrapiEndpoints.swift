//
//  StrapiEndpoints.swift
//  glassnode-swift
//
//  Created by Ondrej Barta on 25.11.23.
//

import Foundation

struct StrapiEndpoints {
    // TODO: Update pagination logic, current solution is brittle
    static let allMetrics = "https://cms.glassnode.com/api/metrics?pagination[limit]=2000&populate[0]=metric_assets"
    static let allMetricAssets = "https://cms.glassnode.com/api/metric-assets?pagination[limit]=500"
    
    static func metricsForAsset(assetSymbol: String) {
        "https://cms.glassnode.com/api/metric-assets/\(assetSymbol)/metrics"
    }
}
