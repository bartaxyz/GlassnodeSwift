//
//  MetricsLoader.swift
//  glassnode-swift
//
//  Created by Ondrej Barta on 25.11.23.
//

import Foundation

import Combine

extension GlassnodeSwift {
    class MetricsLoader: ObservableObject {
        @Published var metrics: Metrics? = nil
        @Published var isLoading = false
        @Published var error: Error?
        
        init() {
            fetchMetrics()
        }
        
        func fetchMetrics() {
            isLoading = true
            error = nil
            Task {
                do {
                    metrics = try await StrapiService.shared.fetchAllMetrics()
                } catch {
                    self.error = error
                }
                isLoading = false
            }
        }
    }
}


/**
// Usage in UI is the following:
struct MetricsView: View {
 @StateObject private var dataLoader = MetricsDataLoader()

 var body: some View {
     List(dataLoader.metrics, id: \.id) { metric in
         // Display each metric
     }
     .onAppear {
         dataLoader.fetchMetrics()
     }
     .overlay {
         if dataLoader.isLoading {
             ProgressView()
         }
     }
     .alert("Error", isPresented: Binding<Bool>(
         get: { dataLoader.error != nil },
         set: { _ in dataLoader.error = nil }
     )) {
         Button("OK", role: .cancel) { }
     } message: {
         Text(dataLoader.error?.localizedDescription ?? "")
     }
 }
}
 */
