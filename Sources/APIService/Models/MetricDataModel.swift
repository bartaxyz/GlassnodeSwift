//
//  MetricDataModel.swift
//  GlassnodeSwift
//
//  Created by Ondrej Barta on 25.11.23.
//

import Foundation

// MARK: - MetricDatum
public struct MetricDataDatum: Codable {
    public let t: Int
    public let v: Double
}

public typealias MetricData = [MetricDataDatum]
