//
//  CaractersRequest.swift
//  RickAndMortyApp
//
//  Created by Мария Газизова on 16.08.2023.
//

import Foundation

struct CharactersRequest: DataRequest {
    var url: String = RickAndMortyEndPoint.characters.url
    var method: HTTPMethod = .get
    
    func decode(_ data: Data) throws -> CharacterResponse {
        let response = try JSONDecoder().decode(CharacterResponse.self, from: data)
        return response
    }
}
