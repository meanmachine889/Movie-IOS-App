//
//  Constants.swift
//  BlossomMovie
//
//  Created by Yash Bharadwaj on 13/03/26.
//

import SwiftUI

struct Constants {
    static let homeString: String = "Home"
    static let searchString: String = "Search"
    static let upcomingString: String = "Upcoming"
    static let downloadString: String = "Download"
    
    static let heroTestTitle: String = "https://lumiere-a.akamaihd.net/v1/images/p_disneymovies_hoppers_poster_officialposter_549f3e14.jpeg"
    
    static let heroTestTitle2: String = "https://m.media-amazon.com/images/M/MV5BNDExNWQ4ZmEtNWVkYy00MzY3LThmMWYtMDcyNTJjMzg4YzdmXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg"
    static let heroTestTitle3: String = "https://lumiere-a.akamaihd.net/v1/images/p_disneymovies_snowwhite2025_poster_v2_78c598d2.jpeg"
    
    static let heroTestTitle4: String = "https://assets-in.bmscdn.com/discovery-catalog/events/tr:w-400,h-600,bg-CCCCCC,e-usm-2-2-0.5-0.008/et00478890-gseacbrsej-portrait.jpg"
    
    static let posterTitleURLStart: String = "https://image.tmdb.org/t/p/w500"
    
    func setPosterPath(to titles: inout[Title]){
        for index in titles.indices {
            if let path = titles[index].posterPath {
                titles[index].posterPath = Constants.posterTitleURLStart + path
            }
        }
    }
    
}

extension Text {
    func PrimaryButtonStyle() -> some View {
        self.foregroundStyle(.buttonText)
            .frame(width: 100, height: 50).bold().background {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.button)
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(.buttonBorder, lineWidth: 1)
                )
        }
    }
}
