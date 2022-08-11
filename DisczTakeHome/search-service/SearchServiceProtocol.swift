//
//  SearchServiceProtocol.swift
//  DisczTakeHome
//
//  Created by Evan Templeton on 8/9/22.
//

import Foundation
/** Protocol used for our SearchService. Inherited by SearchService and SearchServiceMock */
protocol SearchServiceProtocol {
    /**
     - Parameters:
        - searchTerm: Search term provided by the user and added to the URL as a query for key "term"
        - completion: if success, returns an array of search results. If failure, returns an error.
     */
    func fetchResults(with searchTerm: String, completion: @escaping (Result<[SearchResultModel], Error>) -> Void)
    /**
     - Parameters:
        - url: Response object's `previewUrl` parameter, returned by the ITunes Search API: https://tinyurl.com/ycktchj5
        - completion: if success, returns the local filepath to the downloaded audio. If failure, returns an error.
     */
    func downloadAudio(from url: URL, completion: @escaping (Result<URL, Error>) -> Void)
    /**
     - Parameters:
        - url: Response object's `artworkUrl100` parameter, returned by the ITunes Search API: https://tinyurl.com/ycktchj5
        - completion: if success, returns `Data` for the requested image. If failure, returns an error.
     */
    func fetchImage(from url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}
