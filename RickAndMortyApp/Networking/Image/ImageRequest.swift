//
//  ImageRequest.swift
//  RickAndMortyApp
//
//  Created by Мария Газизова on 16.08.2023.
//

import UIKit

struct ImageRequest: DataRequest {
    let url: String
    var method: HTTPMethod = .get
    
    func decode(_ data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else {
            throw NSError(domain: "ErrorResponse.invalidResponse.rawValue",
                          code: 13,
                          userInfo: nil)
        }
        
        return image
    }
}
