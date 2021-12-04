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

        sut.load()

        XCTAssertEqual(httpClient.requestURLs, [url])
    }

    func test_loadTwice_requestDataFromURLTwice() {
        let url = URL(string: "http://some-url.com")!
        let (sut, httpClient) = makeSUT(url: url)

        sut.load()
        sut.load()

        XCTAssertEqual(httpClient.requestURLs, [url, url])
    }

    // MARK: - Helpers

    private func makeSUT(url: URL = URL(string: "http://a-url.com")!) -> (sut: RemoteLandmarkLoader, httpClient: HTTPClientSpy) {
        let httpClient = HTTPClientSpy()
        let sut = RemoteLandmarkLoader(url: url, httpClient: httpClient)

        return (sut, httpClient)
    }

    private class HTTPClientSpy: HTTPClient {
        var requestURLs = [URL]()

        func get(fromURL url: URL) {
            requestURLs.append(url)
        }
    }
}
