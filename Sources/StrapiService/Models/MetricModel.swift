//
//  MetricModel.swift
//  glassnode-swift
//
//  Created by Ondrej Barta on 25.11.23.
//

import Foundation

// MARK: - Metrics
struct Metrics: Codable {
    let data: [Datum]
    let meta: Meta
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let attributes: Attributes
}

// MARK: - Attributes
struct Attributes: Codable {
    let name, group, path, shortName: String
    let formatter: String?
    let description: Description
    let tier: Int
    let metricCode, createdAt, updatedAt: String
    let isPit, isNew: Bool
    let tags: JSONNull?
    let resolutions: [Resolution]
    let currencies: [Currency]
    let formats: [Format]
}

enum Currency: String, Codable {
    case count = "COUNT"
    case native = "NATIVE"
    case usd = "USD"
}

// MARK: - Description
struct Description: Codable {
    let descriptionDefault: String
    let eth, aud, brl, cad: String?
    let chf, cny, eur, gas: String?
    let gbp, jpy, krw, nzd: String?
    let sgd, descriptionTRY, wti, xag: String?
    let xau, bnb, dot, sol: String?
    let atom, matic, stbl: String?

    enum CodingKeys: String, CodingKey {
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

enum Format: String, Codable {
    case csv = "CSV"
    case json = "JSON"
}

enum Resolution: String, Codable {
    case the10M = "10m"
    case the1H = "1h"
    case the1Month = "1month"
    case the1W = "1w"
    case the24H = "24h"
}

// MARK: - Meta
struct Meta: Codable {
    let pagination: Pagination
}

// MARK: - Pagination
struct Pagination: Codable {
    let start, limit, total: Int
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

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
