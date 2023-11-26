//
//  MetricModel.swift
//  glassnode-swift
//
//  Created by Ondrej Barta on 25.11.23.
//

import Foundation

// MARK: - Metrics
public struct Metrics: Codable {
    public let data: [MetricDatum]
    let meta: Meta
}

// MARK: - Datum
public struct MetricDatum: Codable {
    public let id: Int
    public let attributes: MetricAttributes
}

// MARK: - Attributes
public struct MetricAttributes: Codable {
    public let name, group, path, shortName: String
    public let formatter: String?
    public let description: Description?
    public let tier: Int?
    public let metricCode, createdAt, updatedAt: String?
    public let isPit, isNew: Bool?
    public let tags: JSONNull?
    public let resolutions: [Resolution]?
    public let currencies: [Currency]?
    public let formats: [Format]?
    public let metricAssets: FluffyMetricAssets
    
    public enum CodingKeys: String, CodingKey {
        case name, group, path, shortName, formatter, description, tier, metricCode, createdAt, updatedAt, isPit, isNew, tags, resolutions, currencies, formats
        case metricAssets = "metric_assets"
    }
}

public enum Currency: String, Codable {
    case count = "COUNT"
    case native = "NATIVE"
    case usd = "USD"
}

// MARK: - Description
public struct Description: Codable {
    public let descriptionDefault: String
    public let eth, aud, brl, cad: String?
    public let chf, cny, eur, gas: String?
    public let gbp, jpy, krw, nzd: String?
    public let sgd, descriptionTRY, wti, xag: String?
    public let xau, bnb, dot, sol: String?
    public let atom, matic, stbl: String?

    public enum CodingKeys: String, CodingKey {
        case descriptionDefault = "default"
        case eth = "ETH"
        case aud = "AUD"
        case brl = "BRL"
        case cad = "CAD"
        case chf = "CHF"
        case cny = "CNY"
        case eur = "EUR"
        case gas = "GAS"
        case gbp = "GBP"
        case jpy = "JPY"
        case krw = "KRW"
        case nzd = "NZD"
        case sgd = "SGD"
        case descriptionTRY = "TRY"
        case wti = "WTI"
        case xag = "XAG"
        case xau = "XAU"
        case bnb = "BNB"
        case dot = "DOT"
        case sol = "SOL"
        case atom = "ATOM"
        case matic = "MATIC"
        case stbl = "STBL"
    }
}

public enum Format: String, Codable {
    case csv = "CSV"
    case json = "JSON"
}

// MARK: - MetricAssets
public struct FluffyMetricAssets: Codable {
    public let data: [FluffyMetricAssetsDatum]
}

// MARK: - MetricAssetsDatum
public struct FluffyMetricAssetsDatum: Codable {
    public let id: Int
    public let attributes: FluffyAttributes
}

// MARK: - FluffyAttributes
public struct FluffyAttributes: Codable {
    public let name, symbol: String
}

public enum Resolution: String, Codable {
    case the10M = "10m"
    case the1H = "1h"
    case the1Month = "1month"
    case the1W = "1w"
    case the24H = "24h"
}

// MARK: - Meta
public struct Meta: Codable {
    let pagination: Pagination?
}

// MARK: - Pagination
public struct Pagination: Codable {
    public let start, limit, total: Int
}

// MARK: - Encode/decode helpers

public class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
