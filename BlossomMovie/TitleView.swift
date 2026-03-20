//
//  TitleView.swift
//  BlossomMovie
//
//  Created by Yash Bharadwaj on 18/03/26.
//


import SwiftUI

struct TitleView : View {
    
    let title: Title
    var titleName: String { title.name ?? title.title ?? "" }
    
    let viewModel = ViewModal()
    
    var body: some View {
        GeometryReader { geometry in
            switch viewModel.videoIdStatus {
            case .notStarted:
                EmptyView()
            case .loading:
                ProgressView()
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height
                    )
            case .success:
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        YoutubePlayer(videoId: viewModel.videoId)
                            .frame(height: 350)
                        
                        Text(titleName)
                            .bold()
                            .font(.title2)
                            .padding(5)
                        
                        Text(title.overview ?? "").padding(5)
                    }
                }
            case .failure(let underlyingError):
                Text(underlyingError.localizedDescription)
            }
        }
        .task {
            await viewModel.fetchVideoId(for: titleName)
        }
    }
}

#Preview {
    TitleView(title: Title.previewTitles[0])
}
