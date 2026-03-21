//
//  SearchViewModel.swift
//  BlossomMovie
//
//  Created by Yash Bharadwaj on 20/03/26.
//


import Foundation

@Observable
class SearchViewModel {
    private(set) var errorMsg: String?
    private(set) var searchTitles: [Title] = []
    private let df = DataFetcher()
    
    func getSearchTitle(by media: String, for title: String) async {
        do {
            errorMsg = nil
            if title.isEmpty {
                searchTitles = try await df.fetchTitles(media: media, type: "trending")
            } else {
                searchTitles = try await df.fetchTitles(media: media, type: "search", query: title)
            }
        } catch {
            print(error)
            errorMsg = error.localizedDescription
        }
    }
}
