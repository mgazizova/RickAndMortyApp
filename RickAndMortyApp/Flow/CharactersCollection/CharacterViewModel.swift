//
//  CharacterViewModel.swift
//  RickAndMortyApp
//
//  Created by Мария Газизова on 16.08.2023.
//

import Foundation

protocol CharacterViewModel {
    var character: Character { get set }
}

final class CharacterDefaultViewModel: CharacterViewModel {
    var character: Character
    
    init(character: Character) {
        self.character = character
    }
}
