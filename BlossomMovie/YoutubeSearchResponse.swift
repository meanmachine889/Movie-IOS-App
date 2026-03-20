//
//  YoutubeSearchResponse.swift
//  BlossomMovie
//
//  Created by Yash Bharadwaj on 19/03/26.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [ItemProperties]?
}

struct ItemProperties: Codable {
    let id: IdProperties?
}

struct IdProperties: Codable {
    let videoId: String?
    enum CodingKeys: String, CodingKey {
        case videoId = "videoId"
    }
}
