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
    private(set) var videoIdStatus: fetchStatus = .notStarted
    private(set) var upcomingStatus: fetchStatus = .notStarted
    
    private var dataFetcher = DataFetcher()
    var trendingMovies : [Title] = []
    var topRatedMovies : [Title] = []
    var topRatedTV : [Title] = []
    var trendingTV : [Title] = []
    var upcomingMovies : [Title] = []
    var upcomingShows : [Title] = []
    var heroTitle : Title = Title.previewTitles[0]
    var videoId : String = ""
    
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
    
    func fetchVideoId(for title: String) async {
        videoIdStatus = .loading
        
        do {
            videoId = try await dataFetcher.fetchVideoId(for: title)
            videoIdStatus = fetchStatus.success
        } catch {
            print(error)
            videoIdStatus = fetchStatus.failure(underlyingError: error)
        }
    }
    
    func fetchUpcomingMovies() async {
        upcomingStatus = .loading
        
        do {
            upcomingMovies = try await dataFetcher.fetchTitles(media: "movie", type: "upcoming")
            upcomingStatus = .success
        } catch {
            print(error)
            upcomingStatus = .failure(underlyingError: error)
        }
    }
}
