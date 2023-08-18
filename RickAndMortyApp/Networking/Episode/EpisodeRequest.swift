//
//  EpisodeRequest.swift
//  RickAndMortyApp
//
//  Created by Мария Газизова on 18.08.2023.
//

import Foundation

struct EpisodeRequest: DataRequest {
    var id: Int?
    var url: String
    var method: HTTPMethod = .get
    
    init(id: Int) {
        self.id = id
        self.url = RickAndMortyEndPoint.episode(id: id).url
    }
    
    init(url: String) {
        self.url = url
    }
    
    func decode(_ data: Data) throws -> EpisodeDetails {
        let response = try JSONDecoder().decode(EpisodeDetails.self, from: data)
        return response
    }
}
