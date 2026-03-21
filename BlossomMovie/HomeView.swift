//
//  HomeView.swift
//  BlossomMovie
//
//  Created by Yash Bharadwaj on 13/03/26.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    let viewModal = ViewModal()
    @State private var titleDetailPath = NavigationPath()
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack(path: $titleDetailPath){
            GeometryReader { geo in
                ScrollView(.vertical) {
                        
                    switch viewModal.homeStatus {
                    case .loading:
                        ProgressView().frame(width: geo.size.width, height: geo.size.height)
                    case .notStarted:
                        EmptyView()
                    case .success:
                        LazyVStack {
                            AsyncImage(url: URL(string: viewModal.heroTitle.posterPath ?? "")) {
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
                                    titleDetailPath.append(viewModal.heroTitle)
                                } label: {
                                    Text("Play").PrimaryButtonStyle()
                                }
                                
                                Button {
                                    modelContext.insert(viewModal.heroTitle)
                                    try? modelContext.save()
                                } label: {
                                    Text("Download").PrimaryButtonStyle()
                                }
                            }
                            
                            HorizontalView(header: "Trending Movies", titles: viewModal.trendingMovies){
                                title in
                                titleDetailPath.append(title)
                            }
                            
                            HorizontalView(header: "Top Rated Movies", titles: viewModal.topRatedMovies){
                                title in
                                titleDetailPath.append(title)
                            }
                            
                            HorizontalView(header: "Trending TV Shows", titles: viewModal.trendingTV){
                                title in
                                titleDetailPath.append(title)
                            }
                            
                            HorizontalView(header: "Top Rated TV Shows", titles: viewModal.topRatedTV){
                                title in
                                titleDetailPath.append(title)
                            }
                            
                        }
                        .navigationDestination(for: Title.self){
                            title in
                            TitleView(title: title)
                        }
                    case .failure(let error):
                        Text(verbatim: "Failure: \(error.localizedDescription)")
                    }
                }.task {
                    await viewModal.fetchTitles()
                }.navigationDestination(for: Title.self){
                    title in
                    TitleView(title: title)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
