//
//  CharacterResponse.swift
//  RickAndMortyApp
//
//  Created by Мария Газизова on 16.08.2023.
//

import Foundation

struct CharacterResponse: Codable {
    let info: Information
    let results: [Character]
}

struct Information: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
}

struct Origin: Codable {
    let name: String
    let url: String
}

struct Location: Codable {
    let name: String
    let url: String
}
