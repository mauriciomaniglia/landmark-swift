//
//  HTTPClient.swift
//  Landmark-swift
//
//  Created by Mauricio Cesar on 10/08/22.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(fromURL url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
