//
//  Landmark.swift
//  Landmark-swift
//
//  Created by Mauricio Maniglia on 04/12/21.
//

import Foundation

public struct Landmark: Equatable {
    let id: UUID
    let description: String
    let location: String
    let imageURL: URL
}
