//
//  HomeView.swift
//  BlossomMovie
//
//  Created by Yash Bharadwaj on 13/03/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        GeometryReader { geo in
            ScrollView {
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

                    HorizontalView(header: "Trending Movies")
                    HorizontalView(header: "Trending TV")
                    HorizontalView(header: "Top Rated Movies")
                    HorizontalView(header: "Top Rated TV")
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
