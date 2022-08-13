//
//  LandmarkLoader.swift
//  Landmark-swift
//
//  Created by Mauricio Maniglia on 04/12/21.
//

public enum LoaderResult {
    case success([Landmark])
    case failure(Error)
}

public protocol LandmarkLoader {
    func load(completion: @escaping (LoaderResult) -> Void)
}
