//
//  ContentView.swift
//  BlossomMovie
//
//  Created by Yash Bharadwaj on 13/03/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Tab(Constants.homeString, systemImage: "house"){
                HomeView()
            }
            Tab(Constants.upcomingString, systemImage: "play.circle"){
                UpcomingView()
            }
            Tab(Constants.searchString, systemImage: "magnifyingglass") {
                SearchView()
            }
            Tab(Constants.downloadString, systemImage: "arrow.down.to.line") {
                DownloadView()
            }
        }
        .onAppear() {
            if let config = APIConfig.shared {
                print(config.tmdbAPIKey, "API Key")
                print(config.tmdbBaseURL, "Base URL")
            }
        }
    }
}

#Preview {
    ContentView()
}
