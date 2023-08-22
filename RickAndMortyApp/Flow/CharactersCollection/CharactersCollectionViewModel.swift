//
//  CharactersCollectionViewModel.swift
//  RickAndMortyApp
//
//  Created by Мария Газизова on 16.08.2023.
//

import Foundation

protocol CharactersCollectionViewModel {
    var metainfo: Information? { get set }
    var characters: [Character] { get set }
    
    var onFetchCharactersSucceed: (() -> Void)? { get set }
    var onFetchCharactersFailure: ((Error) -> Void)? { get set }
    
    func fetchCharacters()
    func fetchNextCharacters()
}

final class CharactersCollectionDefaultViewModel: CharactersCollectionViewModel {
    var metainfo: Information?
    var characters: [Character] = []
    var onFetchCharactersSucceed: (() -> Void)?
    var onFetchCharactersFailure: ((Error) -> Void)?
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchCharacters() {
        let request = CharactersRequest()
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let characters):
                self?.metainfo = characters.info
                self?.characters = characters.results
                self?.onFetchCharactersSucceed?()
            case .failure(let error):
                self?.onFetchCharactersFailure?(error)
            }
        }
    }
    
    func fetchNextCharacters() {
        guard let metainfo, let url = metainfo.next else { return }
        
        let request = CharactersRequest(url: url)
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let characters):
                self?.metainfo = characters.info
                self?.characters.append(contentsOf: characters.results)
                self?.onFetchCharactersSucceed?()
            case .failure(let error):
                self?.onFetchCharactersFailure?(error)
            }
        }
    }
}
