//
//  LandmarkLoader.swift
//  Landmark-swift
//
//  Created by Mauricio Maniglia on 04/12/21.
//

enum LoaderResult {
    case success([Landmark])
    case failure(Error)
}

protocol LandmarkLoader {
    func load(completion: (LoaderResult) -> Void)
}
