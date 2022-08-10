//
//  RemoteLandmarkLoader.swift
//  Landmark-swift
//
//  Created by Mauricio Maniglia on 04/12/21.
//

import Foundation

public class RemoteLandmarkLoader {
    private let url: URL
    private let httpClient: HTTPClient

    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public enum Result: Equatable {
         case success([Landmark])
         case failure(Error)
     }

    public init(url: URL, httpClient: HTTPClient) {
        self.url = url
        self.httpClient = httpClient
    }

    public func load(completion: @escaping (Result) -> Void) {
        httpClient.get(fromURL: url) { result in
            switch result {
            case let .success(data, response):
                completion(LandmarkMapper.map(data, response))
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
}
