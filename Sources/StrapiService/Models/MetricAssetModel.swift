//
//  MetricAssetModel.swift
//  glassnode-swift
//
//  Created by Ondrej Barta on 26.11.23.
//

import Foundation

// MARK: - MetricAsset
public struct MetricAssets: Codable {
    public let data: [MetricAssetDatum]
    public let meta: Meta
}

// MARK: - Datum
public struct MetricAssetDatum: Codable {
    public let id: Int
    public let attributes: MetricAssetAttributes
}

// MARK: - Attributes
public struct MetricAssetAttributes: Codable {
    public let name, symbol: String
}
