//
//  RemoteLandmarkLoader.swift
//  Landmark-swift
//
//  Created by Mauricio Maniglia on 04/12/21.
//

import Foundation

public protocol HTTPClient {
    func get(fromURL url: URL)
}

public class RemoteLandmarkLoader {
    private let url: URL
    private let httpClient: HTTPClient

    public init(url: URL, httpClient: HTTPClient) {
        self.url = url
        self.httpClient = httpClient
    }

    public func load() {
        httpClient.get(fromURL: url)
    }
}
