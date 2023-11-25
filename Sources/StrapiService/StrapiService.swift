//
//  StrapiService.swift
//  glassnode-swift
//
//  Created by Ondrej Barta on 25.11.23.
//

import Foundation

class StrapiService {
    static let shared = StrapiService()

    private init() {}

    func fetchAllMetrics() async throws -> Metrics {
        let url = URL(string: StrapiEndpoints.allMetrics)!
        return try await NetworkService.shared.request(url: url)
    }
}
