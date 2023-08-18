//
//  EpisodeClient.swift
//  RickAndMortyApp
//
//  Created by Мария Газизова on 18.08.2023.
//

import Foundation

protocol EpisodeClientProtocol {
    func getEpisode<Request: DataRequest>(request: Request,
                                     completion: @escaping (EpisodeDetails?, Error?) -> Void)
    func setEpisode(from url: String,
                    completion: @escaping (EpisodeDetails?) -> Void)
}

final class EpisodeClient: EpisodeClientProtocol {
    static let shared = EpisodeClient(responseQueue: .main,
                                      session: URLSession.shared)
    
    let responseQueue: DispatchQueue?
    let session: URLSession?
    
    private var cachedEpisodeForURL: [String: EpisodeDetails]
    
    init(responseQueue: DispatchQueue?, 
         session: URLSession?) {
        self.responseQueue = responseQueue
        self.session = session
        self.cachedEpisodeForURL = [:]
    }
    
    private func dispatchEpisode(episode: EpisodeDetails? = nil,
                                 error: Error? = nil,
                                 completion: @escaping (EpisodeDetails?, Error?) -> Void) {
        guard let responseQueue else {
            completion(episode, error)
            return
        }
        
        responseQueue.async {
            completion(episode, error)
        }
    }
    
    func getEpisode<Request: DataRequest>(request: Request,
                                          completion: @escaping (EpisodeDetails?, Error?) -> Void){
        let service: NetworkService = DefaultNetworkService()
        service.request(request) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                guard let episode = response as? EpisodeDetails else {
                    return
                }
                self.dispatchEpisode(episode: episode, completion: completion)
            case .failure(let error):
                self.dispatchEpisode(error: error, completion: completion)
            }
        }
    }
    
    func setEpisode(from url: String, 
                    completion: @escaping (EpisodeDetails?) -> Void) {
        let request = EpisodeRequest(url: url)
        
        if let cachedEpisode = cachedEpisodeForURL[url] {
            completion(cachedEpisode)
            return
        }
        
        getEpisode(request: request) { [weak self] episode, error in
            guard let self else { return }
            
            guard let episode else {
                print(error?.localizedDescription)
                return
            }
            
            self.cachedEpisodeForURL[url] = episode
            completion(episode)
        }
    }
}
