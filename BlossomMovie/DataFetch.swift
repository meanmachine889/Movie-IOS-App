//
//  DataFetch.swift
//  BlossomMovie
//
//  Created by Yash Bharadwaj on 18/03/26.
//


import Foundation

struct DataFetcher {
    
    let tmdbURL = APIConfig.shared?.tmdbBaseURL
    let tmdbAPI = APIConfig.shared?.tmdbAPIKey
    
    
    func fetchTitles(media : String) async throws -> [Title] {
        guard let baseUrl = tmdbURL else {
            throw NetworkError.missingConfig
        }
        
        guard let apiKey = tmdbAPI else {
            throw NetworkError.missingConfig
        }
        
        guard let fetchTitleURL = URL(string: baseUrl)?
            .appending(path: "3/trending/\(media)/day")
            .appending(queryItems: [
                URLQueryItem(name: "api_key", value: apiKey)
            ]) else {
            throw NetworkError.urlBuildingFailed
        }
        
        print(fetchTitleURL)
        
        let (data, urlResponse) = try await URLSession.shared.data(from: fetchTitleURL)
        
        guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badURLResponse(underlyingError : NSError(
                domain: "DataFetcher",
                code: (urlResponse as? HTTPURLResponse)?.statusCode ?? -1,
                userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP response"])
            )
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        var titles = try decoder.decode(APIObj.self, from: data).results
        let constants = Constants()
        constants.setPosterPath(to: &titles)
        return titles
    }
}

