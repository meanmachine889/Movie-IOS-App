//
//  Error.swift
//  BlossomMovie
//
//  Created by Yash Bharadwaj on 16/03/26.
//

import Foundation

enum APIConfigError: Error, LocalizedError {
    case fileNotFound
    case dataLoadingFailed(underlyingError: Error)
    case decodingFailed(underlyingError: Error)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "File not found"
        case let .dataLoadingFailed(underlyingError):
            return "Data loading failed: \(underlyingError.localizedDescription)"
        case let .decodingFailed(underlyingError):
            return "Decoding failed: \(underlyingError.localizedDescription)"
        }
    }
}

enum NetworkError: Error, LocalizedError {
    case badURLResponse(underlyingError: Error)
    case missingConfig
    case urlBuildingFailed
    
    var errorDescription: String? {
        switch self {
        case let .badURLResponse(underlyingError):
            return "Bad URL response: \(underlyingError.localizedDescription)"
        case .missingConfig:
            return "Missing configuration"
            
        case .urlBuildingFailed:
            return "URL building failed"
        }
    }
}
