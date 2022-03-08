//
//  Landmark.swift
//  Landmark-swift
//
//  Created by Mauricio Maniglia on 04/12/21.
//

import Foundation

public struct Landmark: Equatable {
    public let id: UUID
    public let description: String?
    public let location: String?
    public let imageURL: URL
    
    public init(id: UUID, description: String?, location: String?, imageURL: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.imageURL = imageURL
    }
}

extension Landmark: Decodable {

    private enum CodingKeys: String, CodingKey {
        case id
        case description
        case location
        case imageURL = "image"
    }
}
