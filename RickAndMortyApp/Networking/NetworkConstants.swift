//
//  NetworkConstants.swift
//  RickAndMortyApp
//
//  Created by Мария Газизова on 16.08.2023.
//

import Foundation

enum RickAndMortyEndPoint {
    case characters
    case location(id: Int)
    case episode(id: Int)
}

extension RickAndMortyEndPoint {
    private var baseUrl: String {
        return "https://rickandmortyapi.com"
    }
    
    private var path: String {
        switch self {
        case .characters:
            return "/api/character"
        case let .location(id):
            return "/api/location/\(id)"
        case let .episode(id):
            return "api/episode/\(id)"
        }
    }
    
    var url: String {
        return baseUrl + path
    }
}
