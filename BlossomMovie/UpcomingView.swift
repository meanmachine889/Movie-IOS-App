//
//  UpcomingView.swift
//  BlossomMovie
//
//  Created by Yash Bharadwaj on 20/03/26.
//

import SwiftUI

struct UpcomingView : View {
    let viewModel = ViewModal()
    var body: some View {
        NavigationStack{
            GeometryReader { geo in
                switch viewModel.upcomingStatus {
                case .notStarted:
                    EmptyView()
                case .loading:
                    ProgressView().frame(width: geo.size.width, height: geo.size.height)
                case .success:
                    VerticalListView(titles: viewModel.upcomingMovies)
                case .failure(let underlyingError):
                    Text("Error: \(underlyingError.localizedDescription)")
                }
            }.task {
                await viewModel.fetchUpcomingMovies()
            }
        }
    }
}
