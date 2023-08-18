//
//  LocationClient.swift
//  RickAndMortyApp
//
//  Created by Мария Газизова on 18.08.2023.
//

import Foundation

protocol LocationClientProtocol {
    func getLocation<Request: DataRequest>(request: Request,
                                           completion: @escaping (LocationDetails?, Error?) -> Void)
    func setLocation(from url: String,
                     completion: @escaping (LocationDetails?) -> Void)
}

final class LocationClient: LocationClientProtocol {
    static let shared = LocationClient(responseQueue: .main,
                                       session: URLSession.shared)
    
    let responseQueue: DispatchQueue?
    let session: URLSession?
    
    private var cachedLocationForURL: [String: LocationDetails]
    
    init(responseQueue: DispatchQueue?, session: URLSession?) {
        self.responseQueue = responseQueue
        self.session = session
        self.cachedLocationForURL = [:]
    }
    
    private func dispatchLocation(location: LocationDetails? = nil,
                          error: Error? = nil,
                          completion: @escaping (LocationDetails?, Error?) -> Void) {
        guard let responseQueue else {
            completion(location, error)
            return
        }
        
        responseQueue.async {
            completion(location, error)
        }
    }
    
    func getLocation<Request: DataRequest>(request: Request, 
                                           completion: @escaping (LocationDetails?, Error?) -> Void) {
        let service: NetworkService = DefaultNetworkService()
        service.request(request) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                guard let location = response as? LocationDetails else {
                    return
                }
                self.dispatchLocation(location: location, completion: completion)
            case .failure(let error):
                self.dispatchLocation(error: error, completion: completion)
            }
        }
    }
    
    func setLocation(from url: String,
                     completion: @escaping (LocationDetails?) -> Void) {
        let request = LocationRequest(url: url)
        
        if let cacheLocation = cachedLocationForURL[url] {
            completion(cacheLocation)
            return
        }
        
        getLocation(request: request) { [weak self] location, error in
            guard let self else { return }
            
            guard let location else {
                print(error?.localizedDescription)
                return
            }
            
            self.cachedLocationForURL[url] = location
            completion(location)
        }
    }
}
