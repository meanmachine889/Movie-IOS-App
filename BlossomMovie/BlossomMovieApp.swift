//
//  BlossomMovieApp.swift
//  BlossomMovie
//
//  Created by Yash Bharadwaj on 13/03/26.
//

import SwiftUI
import SwiftData

@main
struct BlossomMovieApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Title.self)
    }
}
