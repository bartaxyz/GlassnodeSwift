//
//  NetworkService.swift
//  glassnode-swift
//
//  Created by Ondrej Barta on 25.11.23.
//

import Foundation

/*class NetworkService {
    static let shared = NetworkService()
    
    struct CachedData {
        let data: Data
        let timestamp: Date
    }
    
    private var cache = [URL: CachedData]()
    private let cacheTimeout: TimeInterval = 300

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
}*/
import Foundation

class NetworkService {
    static let shared = NetworkService()
    private var ongoingRequests = [URL: Task<Data, Error>]()
    private var cache = [URL: CachedData<Any>]()
    private let cacheTimeout: TimeInterval = 300 // 5 minutes
    private let queue = DispatchQueue(label: "com.bartaxyz.GlassnodeSwift.NetworkService")

    private struct CachedData<T> {
        let data: T
        let timestamp: Date
    }

    private init() {}

    func request<T: Codable>(url: URL) async throws -> T {
        // Check cache first
        /*if let cachedData = cache[url] as? CachedData<T>, Date().timeIntervalSince(cachedData.timestamp) < cacheTimeout {
            print("READING FROM CACHE")
            return cachedData.data
        }*/
        
        print("REQUEST STARTED: " + url.absoluteString);

        // Check for an existing request
        if let existingTask = queue.sync(execute: { ongoingRequests[url] }) {
            let data = try await existingTask.value
            return try decodeAndCache(data, for: url)
        }

        // Start a new request
        let task = Task { () -> Data in
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("NetworkService: Error Fetching Data")
                print(response)
                throw NetworkError.invalidResponse
            }
            return data
        }

        // Store the task
        queue.sync {
            ongoingRequests[url] = task
        }

        // Await the task's result and update cache
        let data = try await task.value
        print("REQUEST FINISHED")
        return try queue.sync {
            try decodeAndCache(data, for: url)
        }
    }

    private func decodeAndCache<T: Codable>(_ data: Data, for url: URL) throws -> T {
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        // cache[url] = CachedData(data: decodedData, timestamp: Date())
        return decodedData
    }
}
