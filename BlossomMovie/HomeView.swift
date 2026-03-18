//
//  HomeView.swift
//  BlossomMovie
//
//  Created by Yash Bharadwaj on 13/03/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        let viewModal = ViewModal()
        
        GeometryReader { geo in
            ScrollView(.vertical) {
                
                switch viewModal.homeStatus {
                case .loading:
                    ProgressView()
                case .notStarted:
                    EmptyView()
                case .success:
                    LazyVStack {
                        AsyncImage(url: URL(string: Constants.heroTestTitle)) {
                            image in
                            image
                                .resizable()
                                .scaledToFit()
                                .overlay {
                                    LinearGradient(
                                        stops: [Gradient.Stop(color: .clear, location: 0.8), Gradient.Stop(color: .gradient, location: 1)],
                                        startPoint: .top,
                                        endPoint: .bottom)
                                }
                        } placeholder: {
                            ProgressView()
                        }.frame(
                            width: geo.size.width,
                            height: geo.size.height * 0.85
                        )

                        HStack {
                            Button {

                            } label: {
                                Text("Play").PrimaryButtonStyle()
                            }

                            Button {

                            } label: {
                                Text("Download").PrimaryButtonStyle()
                            }
                        }
                        
                        HorizontalView(header: "Trending Movies", titles: viewModal.trendingMovies)

                                        }
                case .failure(let error):
                    Text(verbatim: "Failure: \(error.localizedDescription)")
                }
            }.task {
                await viewModal.fetchTrendingMovies()
            }
        }
    }
}

#Preview {
    HomeView()
}
