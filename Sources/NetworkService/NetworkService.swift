//
//  NetworkService.swift
//  glassnode-swift
//
//  Created by Ondrej Barta on 25.11.23.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()

    private init() {}

    // Generic request function that can fetch and decode any Codable object
    func request<T: Codable>(url: URL) async throws -> T {
        // Use URLSession to perform the network request
        let (data, response) = try await URLSession.shared.data(from: url)

        // Check for HTTP errors and status codes here
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        // Decode the JSON data into the specified Codable type (T)
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}
