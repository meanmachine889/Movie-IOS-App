//
//  SearchView.swift
//  BlossomMovie
//
//  Created by Yash Bharadwaj on 20/03/26.
//

import SwiftUI

struct SearchView: View {
    var titles = Title.previewTitles
    @State private var searchMovie = true
    @State private var searchtext: String = ""
    @State private var navPath = NavigationPath()
    
    let searchVM = SearchViewModel()
    
    var body: some View {
        NavigationStack(path: $navPath) {
            ScrollView {
                if let error = searchVM.errorMsg, error != "cancelled" {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 10))
                }
                LazyVGrid (columns: [GridItem(), GridItem(), GridItem()]) {
                    ForEach(searchVM.searchTitles) { title in
                        AsyncImage(url: URL(string: title.posterPath ?? " ")) { image in
                            image.resizable().scaledToFit().clipShape(.rect(cornerRadius: 10))
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 120, height: 200)
                        .onTapGesture {
                            navPath.append(title)
                        }
                    }
                }
            }.padding()
                .navigationTitle(searchMovie ? "Movies" : "TV Shows")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            searchMovie.toggle()
                            
                            Task {
                                await searchVM.getSearchTitle(by: searchMovie ? "movie" : "tv", for: searchtext)
                            }
                            
                        } label: {
                            Image(systemName: !searchMovie ? "tv" : "movieclapper")
                        }
                    }
                }
                .searchable(text: $searchtext, prompt: searchMovie ? "Search Movies" : "Search TV Shows")
                .task(id: searchtext) {
                    try? await Task.sleep(for: .milliseconds(500))
                    
                    await searchVM.getSearchTitle(by: searchMovie ? "movie" : "tv", for: searchtext)
                }
                .navigationDestination(for: Title.self) { title in
                    TitleView(title: title)
                }
        }
    }
}

#Preview {
    NavigationView {
        SearchView()
    }
}
