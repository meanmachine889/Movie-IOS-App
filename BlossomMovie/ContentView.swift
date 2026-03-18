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
                Text(Constants.upcomingString)
            }
            Tab(Constants.searchString, systemImage: "magnifyingglass") {
                Text(Constants.searchString)
            }
            Tab(Constants.downloadString, systemImage: "arrow.down.to.line") {
                Text(Constants.downloadString)
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
