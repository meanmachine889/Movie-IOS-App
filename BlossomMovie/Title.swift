//
//  Title.swift
//  BlossomMovie
//
//  Created by Yash Bharadwaj on 14/03/26.
//

import SwiftData

struct TMDBAPIObj : Decodable {
    var results: [Title]
}

@Model
class Title : Decodable, Identifiable, Hashable {
    @Attribute(.unique) var id: Int?
    var title: String?
    var name: String?
    var overview: String?
    var posterPath: String?
    var backdrop_path: String?
    
    init(id: Int? = nil, title: String? = nil, name: String? = nil, overview: String? = nil, posterPath: String? = nil, backdrop_path: String? = nil) {
        self.id = id
        self.title = title
        self.name = name
        self.overview = overview
        self.posterPath = posterPath
        self.backdrop_path = backdrop_path
    }
    
    enum CodingKeys: CodingKey {
        case id
        case title
        case name
        case overview
        case posterPath
        case backdrop_path
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        backdrop_path = try container.decodeIfPresent(String.self, forKey: .backdrop_path)
    }
    
    static var previewTitles = [
        Title(id: 1, title: "BeetleJuice", name: "BeetleJuice", overview: "Movie about BeetleJuice", posterPath: Constants.heroTestTitle)
    ]
}
