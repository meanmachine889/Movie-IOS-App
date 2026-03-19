//
//  Title.swift
//  BlossomMovie
//
//  Created by Yash Bharadwaj on 14/03/26.
//

import Foundation

struct TMDBAPIObj : Decodable {
    var results: [Title]
}

struct Title : Decodable, Identifiable, Hashable {
    var id: Int?
    var title: String?
    var name: String?
    var overview: String?
    var posterPath: String?
    var backdrop_path: String?
    
    static var previewTitles = [
        Title(id: 1, title: "BeetleJuice", name: "BeetleJuice", overview: "Movie about BeetleJuice", posterPath: Constants.heroTestTitle)
    ]
}
