//
//  LandmarkMapper.swift
//  Landmark-swift
//
//  Created by Mauricio Cesar on 10/08/22.
//

import Foundation

class LandmarkMapper {
    private struct Root: Decodable {
        let items: [Item]
        
        var landmark: [Landmark] {
            return items.map { $0.item }
        }
    }

    private struct Item: Decodable {
        let id: UUID
        let description: String?
        let location: String?
        let image: URL
        
        var item: Landmark {
            return Landmark(id: id, description: description, location: location, imageURL: image)
        }
    }
    
    static func map(_ data: Data, _ response: HTTPURLResponse) -> RemoteLandmarkLoader.Result {
        guard response.statusCode == 200, let root = try? JSONDecoder().decode(Root.self, from: data) else {
            return .failure(RemoteLandmarkLoader.Error.invalidData)
        }
        
        return .success(root.landmark)
    }
}
