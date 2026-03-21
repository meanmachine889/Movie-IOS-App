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
    let youtubeSearchURL = APIConfig.shared?.youtubeSearchURL
    let youtubeAPIKey = APIConfig.shared?.youtubeAPIKey
    
    func fetchTitles(media : String, type: String, query: String? = nil) async throws -> [Title] {
        
        let fetchTitleURL = try buildUrl(for: media, of: type, searchPhrase: query)
        
        guard let fetchTitleURL = fetchTitleURL else {
            throw NetworkError.urlBuildingFailed
        }
        
        var titles = try await fetchAndDecode(url: fetchTitleURL, type: TMDBAPIObj.self).results
        let constants = Constants()
        constants.setPosterPath(to: &titles)
        return titles
    }
    
    func fetchVideoId(for title: String) async throws -> String {
        guard let ytbaseurl = youtubeSearchURL else {
            throw NetworkError.missingConfig
        }
        
        guard let ytAPIKey = youtubeAPIKey else {
            throw NetworkError.missingConfig
        }
        
        let trailerSearch = title + YoutubeURLStrings.space.rawValue + YoutubeURLStrings.trailer.rawValue
        
        guard let fetchVideoURL = URL(string: ytbaseurl)?.appending(queryItems: [
            URLQueryItem(name: YoutubeURLStrings.queryShorten.rawValue, value: trailerSearch),
            URLQueryItem(name: YoutubeURLStrings.key.rawValue, value: ytAPIKey)
        ]) else {
            throw NetworkError.urlBuildingFailed
        }
        
        print(fetchVideoURL)
        
        return try await fetchAndDecode(url: fetchVideoURL, type: YoutubeSearchResponse.self).items?.first?.id?.videoId ?? ""
    }
    
    func fetchAndDecode<T: Decodable>(url: URL, type: T.Type) async throws -> T {
        let (data, urlResponse) = try await URLSession.shared.data(from: url)
        
        guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badURLResponse(underlyingError : NSError(
                domain: "DataFetcher",
                code: (urlResponse as? HTTPURLResponse)?.statusCode ?? -1,
                userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP response"])
            )
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(type, from: data)
    }
    
    func buildUrl(for media: String, of type: String, searchPhrase: String? = nil) throws -> URL? {
        guard let baseUrl = tmdbURL else {
            throw NetworkError.missingConfig
        }
        
        guard let apiKey = tmdbAPI else {
            throw NetworkError.missingConfig
        }
        
        var path: String = ""
        
        if type == "trending" {
            path = "3/\(type)/\(media)/day"
        } else if type == "top_rated" || type == "upcoming" {
            path = "3/\(media)/\(type)"
        } else if type == "search" {
            path = "3/\(type)/\(media)"
        }
        else {
            throw NetworkError.urlBuildingFailed
        }
        
        var urlQueryItems: [URLQueryItem] = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        if searchPhrase != nil {
            urlQueryItems.append(URLQueryItem(name: "query", value: searchPhrase!))
        }
        
        guard let url = URL(string: baseUrl)?
            .appending(path: path)
            .appending(queryItems: urlQueryItems) else {
            throw NetworkError.urlBuildingFailed
        }
        
        return url
    }
}

