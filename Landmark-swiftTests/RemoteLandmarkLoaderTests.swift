//
//  RemoteLandmarkLoaderTests.swift
//  Landmark-swiftTests
//
//  Created by Mauricio Maniglia on 04/12/21.
//

import XCTest
import Landmark_swift

class RemoteLandmarkLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let (_, httpClient) = makeSUT()

        XCTAssertTrue(httpClient.requestURLs.isEmpty)
    }

    func test_load_requestDataFromURL() {
        let url = URL(string: "http://some-url.com")!
        let (sut, httpClient) = makeSUT(url: url)

        sut.load { _ in }

        XCTAssertEqual(httpClient.requestURLs, [url])
    }

    func test_loadTwice_requestDataFromURLTwice() {
        let url = URL(string: "http://some-url.com")!
        let (sut, httpClient) = makeSUT(url: url)

        sut.load { _ in }
        sut.load { _ in }

        XCTAssertEqual(httpClient.requestURLs, [url, url])
    }

    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()

        var capturedErrors = [RemoteLandmarkLoader.Error]()
        sut.load { capturedErrors.append($0) }

        let clientError = NSError(domain: "Test", code: 0)
        client.complete(with: clientError)

        XCTAssertEqual(capturedErrors, [.connectivity])
    }

    func test_load_deliversErrorOnNon200HTTPClientResponse() {
        let (sut, client) = makeSUT()

        let samples = [199, 201, 300, 400, 500]

        samples.enumerated().forEach { index, code in
            var capturedErrors = [RemoteLandmarkLoader.Error]()
            sut.load { capturedErrors.append($0) }

            client.complete(withStatusCode: code, at: index)

            XCTAssertEqual(capturedErrors, [.invalidData])
        }
    }

    // MARK: - Helpers

    private func makeSUT(url: URL = URL(string: "http://a-url.com")!) -> (sut: RemoteLandmarkLoader, httpClient: HTTPClientSpy) {
        let httpClient = HTTPClientSpy()
        let sut = RemoteLandmarkLoader(url: url, httpClient: httpClient)

        return (sut, httpClient)
    }

    private class HTTPClientSpy: HTTPClient {
        var messages = [(url: URL, completion: (HTTPClientResult) -> Void)]()
        var requestURLs: [URL] {
            return messages.map { $0.url }
        }

        func get(fromURL url: URL, completion: @escaping (HTTPClientResult) -> Void) {            
            messages.append((url, completion))
        }

        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(.failure(error))
        }

        func complete(withStatusCode code: Int, at index: Int = 0) {
            let response = HTTPURLResponse(url: requestURLs[index],
                                           statusCode: code,
                                           httpVersion: nil,
                                           headerFields: nil)!
            messages[index].completion(.success(response))
        }
    }
}
