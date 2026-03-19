//
//  TitleView.swift
//  BlossomMovie
//
//  Created by Yash Bharadwaj on 18/03/26.
//


import SwiftUI

struct TitleView : View {
    
    let title: Title
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack(alignment: .leading) {
                    YoutubePlayer(videoId: "dQw4w9WgXcQ")
                        .aspectRatio(1.3 ,contentMode: .fit)
                    
                    Text((title.name ?? title.title) ?? "")
                        .bold()
                        .font(.title2)
                        .padding(5)
                    
                    Text(title.overview ?? "").padding(5)
                }
            }
        }
    }
}

#Preview {
    TitleView(title: Title.previewTitles[0])
}
