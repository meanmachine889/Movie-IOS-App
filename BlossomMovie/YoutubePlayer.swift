//
//  YoutubePlayer.swift
//  BlossomMovie
//
//  Created by Yash Bharadwaj on 19/03/26.
//

import SwiftUI
import YouTubeiOSPlayerHelper

struct YoutubePlayer: UIViewRepresentable {
    let videoId: String

    func makeUIView(context: Context) -> YTPlayerView {
        let player = YTPlayerView()
        return player
    }

    func updateUIView(_ uiView: YTPlayerView, context: Context) {
        uiView.load(withVideoId: videoId)
    }
}
