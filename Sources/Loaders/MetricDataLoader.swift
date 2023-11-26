//
//  DataLoader.swift
//  GlassnodeSwift
//
//  Created by Ondrej Barta on 25.11.23.
//

import Foundation

import Combine

extension GlassnodeSwift {
    public class MetricDataLoader: ObservableObject {
        @Published var data: MetricData? = nil
        @Published var isLoading = false
        @Published var error: Error?
        
        var metricPath: String
        var assetSymbol: String
        
        public init(metricPath: String, assetSymbol: String) {
            self.metricPath = metricPath
            self.assetSymbol = assetSymbol
            
            do {
                try fetchMetricData()
            } catch {}
        }
        
        func fetchMetricData() throws {
            guard GlassnodeSwift.configuration.apiKey == nil else {
                throw GlassnodeSwiftError.apiKeyNotProvided
            }
            
            isLoading = true
            error = nil
            Task {
                do {
                    data = try await APIService.fetchMetricData(metricPath: metricPath, assetSymbol: assetSymbol)
                } catch {
                    self.error = error
                }
                isLoading = false
            }
        }
    }
}
