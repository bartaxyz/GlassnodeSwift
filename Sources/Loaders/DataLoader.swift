//
//  DataLoader.swift
//  GlassnodeSwift
//
//  Created by Ondrej Barta on 25.11.23.
//

import Foundation

import Combine

extension GlassnodeSwift {
    class DataLoader: ObservableObject {
        // TODO: Update for proper type
        @Published var data: Metrics? = nil
        @Published var isLoading = false
        @Published var error: Error?
        
        init() {
            do {
                try fetchMetrics()
            } catch {}
        }
        
        func fetchMetrics() throws {
            guard GlassnodeSwift.configuration.apiKey == nil else {
                throw GlassnodeSwiftError.apiKeyNotProvided
            }
            
            isLoading = true
            error = nil
            Task {
                do {
                    data = try await StrapiService.shared.fetchAllMetrics()
                } catch {
                    self.error = error
                }
                isLoading = false
            }
        }
    }
}
