//
//  CharactersDetailsViewModel.swift
//  RickAndMortyApp
//
//  Created by Мария Газизова on 17.08.2023.
//

import SwiftUI

protocol CharacterDetailsViewModel: ObservableObject {
    var character: Character { get set }
    var image: Image? { get set }
    var origin: LocationDetails? { get set }
    var episodes: [EpisodeDetails] { get set }
}

final class CharactersDetailsDefaultViewModel: CharacterDetailsViewModel {
    @Published var image: Image?
    @Published var origin: LocationDetails?
    @Published var episodes: [EpisodeDetails] = []
    
    var character: Character
    
    init(character: Character) {
        self.character = character
    }
}
