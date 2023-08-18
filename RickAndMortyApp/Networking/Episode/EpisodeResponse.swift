//
//  EpisodeResponse.swift
//  RickAndMortyApp
//
//  Created by Мария Газизова on 18.08.2023.
//

import Foundation

struct EpisodeDetails: Codable, Identifiable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episode
    }
}
