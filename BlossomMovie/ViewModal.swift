//
//  ViewModal.swift
//  BlossomMovie
//
//  Created by Yash Bharadwaj on 18/03/26.
//

import Foundation

@Observable

class ViewModal {
    enum fetchStatus {
        case notStarted
        case loading
        case success
        case failure(underlyingError : Error)
    }
    
    private(set) var homeStatus : fetchStatus = .notStarted
    
    private var dataFetcher = DataFetcher()
    var trendingMovies : [Title] = []
    
    func fetchTrendingMovies() async {
        self.homeStatus = .loading
        
        do {
            trendingMovies = try await dataFetcher.fetchTitles(media: "movie")
            self.homeStatus = .success
        } catch {
            print(error)
            self.homeStatus = .failure(underlyingError: error)
        }
    }
}
