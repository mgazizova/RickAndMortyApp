//
//  ImageClient.swift
//  RickAndMortyApp
//
//  Created by Мария Газизова on 16.08.2023.
//

import UIKit

protocol ImageClientProtocol {
    func downloadImage<Request: DataRequest>(request: Request,
                                             completion: @escaping (UIImage?, Error?) -> Void)
    func setImage(from url: String,
                  placeholderImage: UIImage?,
                  completion: @escaping (UIImage?) -> Void)
}

final class ImageClient: ImageClientProtocol {
    static let shared = ImageClient(responseQueue: .main,
                                    session: URLSession.shared)
    
    let responseQueue: DispatchQueue?
    let session: URLSession?
    
    private var cachedImageForURL: [String: UIImage]
    
    init(responseQueue: DispatchQueue?, session: URLSession?) {
        self.responseQueue = responseQueue
        self.session = session
        self.cachedImageForURL = [:]
    }
    
    private func dispatchImage(image: UIImage? = nil,
                          error: Error? = nil,
                          completion: @escaping (UIImage?, Error?) -> Void) {
        guard let responseQueue else {
            completion(image, error)
            return
        }
        
        responseQueue.async {
            completion(image, error)
        }
    }
    
    func downloadImage<Request: DataRequest>(request: Request,
                                completion: @escaping (UIImage?, Error?) -> Void) {
        let service: NetworkService = DefaultNetworkService()
        service.request(request) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                guard let image = response as? UIImage else { return }
                self.dispatchImage(image: image, completion: completion)
            case .failure(let error):
                self.dispatchImage(error: error, completion: completion)
            }
        }
    }
    
    func setImage(from url: String, 
                  placeholderImage: UIImage?,
                  completion: @escaping (UIImage?) -> Void) {
        let request = ImageRequest(url: url)
        
        if let cacheImage = cachedImageForURL[url] {
            completion(cacheImage)
            return
        }
        
        downloadImage(request: request) { [weak self] image, error in
            guard let self else { return }
            
            guard let image else {
                print(error?.localizedDescription)
                return
            }
            
            self.cachedImageForURL[url] = image
            completion(image)
        }
    }
}
