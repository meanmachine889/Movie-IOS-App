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
    var topRatedMovies : [Title] = []
    var topRatedTV : [Title] = []
    var trendingTV : [Title] = []
    var heroTitle : Title = Title.previewTitles[0]
    
    func fetchTitles() async {
        self.homeStatus = .loading
        
        if trendingMovies.isEmpty{
            
            do {
                async let trm = dataFetcher.fetchTitles(media: "movie", type: "trending")
                async let tm = dataFetcher.fetchTitles(media: "movie", type: "top_rated")
                async let trt = dataFetcher.fetchTitles(media: "tv", type: "trending")
                async let tt = dataFetcher.fetchTitles(media: "tv", type: "top_rated")
                
                topRatedMovies = try await tm
                trendingMovies = try await trm
                topRatedTV = try await tt
                trendingTV = try await trt
                
                if let title = trendingMovies.randomElement() {
                    heroTitle = title
                }
                
                self.homeStatus = .success
            } catch {
                print(error)
                self.homeStatus = .failure(underlyingError: error)
            }
        } else {
            self.homeStatus = .success 
        }
    }
}
