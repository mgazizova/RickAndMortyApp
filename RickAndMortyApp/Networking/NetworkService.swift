//
//  NetworkService.swift
//  RickAndMortyApp
//
//  Created by Мария Газизова on 16.08.2023.
//

import Foundation

protocol NetworkService {
    func request<Request: DataRequest>(_ request: Request,
                                       completion: @escaping (Result<Request.Response, Error>) -> Void)
}

final class DefaultNetworkService: NetworkService {
    func request<Request: DataRequest>(_ request: Request,
                          completion: @escaping (Result<Request.Response, Error>) -> Void) {
        guard var urlComponent = URLComponents(string: request.url) else {
            let error = NSError(domain: "ErrorResponse.invalidEndpoint.rawValue",
                                code: 404,
                                userInfo: nil)
            
            return completion(.failure(error))
        }
        
        request.queryItems.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            urlComponent.queryItems?.append(urlQueryItem)
        }
        
        guard let url = urlComponent.url else {
            let error = NSError(domain: "ErrorResponse.invalidEndpoint.rawValue",
                                code: 404,
                                userInfo: nil)
            
            return completion(.failure(error))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error {
                return completion(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(NSError()))
            }
            
            guard let data else {
                return completion(.failure(NSError()))
            }
            
            do {
                try completion(.success(request.decode(data)))
            } catch let error as NSError {
                completion(.failure(error))
            }
        }
        .resume()
    }
}
