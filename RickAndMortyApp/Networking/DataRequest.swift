//
//  DataRequest.swift
//  RickAndMortyApp
//
//  Created by Мария Газизова on 16.08.2023.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol DataRequest {
    associatedtype Response
    
    var url: String { get }
    var method: HTTPMethod { get }
    var queryItems: [String: String] { get }
    
    func decode(_ data: Data) throws -> Response
}

extension DataRequest where Response: Decodable {
    func decode(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
}

extension DataRequest {
    var queryItems: [String : String] {
        [:]
    }
}
