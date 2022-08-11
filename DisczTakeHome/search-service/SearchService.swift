//
//  SearchService.swift
//  DisczTakeHome
//
//  Created by Evan Templeton on 8/7/22.
//

import Foundation

enum SearchServiceError: Error, LocalizedError {
    case invalidUrl
    case results
    case decoding
    case download
    case audio
    case generic
    
    public var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .results:
            return "Error fetching results"
        case .decoding:
            return "Error decoding JSON"
        case .download:
            return "Error downloading audio"
        case .audio:
            return "Error playing audio from URL"
        case .generic:
            return "Something went wrong."
        }
    }
}


class SearchService: SearchServiceProtocol {
    // MARK: - Public Methods
    public func fetchResults(with searchTerm: String, completion: @escaping (Result<[SearchResultModel], Error>) -> Void) {
        
        guard let url = urlForQuery(searchTerm: searchTerm) else {
            return completion(.failure(SearchServiceError.invalidUrl))
        }
        
        getRequest(with: url) { result in
            switch result {
            case .success(let data):
                if let decodedResponse = try? JSONDecoder().decode(ITunesAPIResponse.self, from: data) {
                    let models = decodedResponse.results.compactMap {
                        self.convertResponseToModel(response: $0)
                    }
                    completion(.success(models))
                } else {
                    completion(.failure(SearchServiceError.decoding))
                }
            case .failure:
                completion(.failure(SearchServiceError.results))
            }
        }
    }
    
    
    public func fetchImage(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        getRequest(with: url, completion: completion)
    }
    
    
    public func downloadAudio(from url: URL, completion: @escaping (Result<URL, Error>) -> Void) {
        download(from: url, completion: completion)
    }
    
    
    // MARK: - Private Methods
    private func urlForQuery(searchTerm: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = "/search"
        components.queryItems = [URLQueryItem(name: "term", value: searchTerm),
                                 URLQueryItem(name: "limit", value: "5"),
                                 URLQueryItem(name: "media", value: "music")]
        
        return components.url
    }
    
    
    private func getRequest(with url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            if let response = response as? HTTPURLResponse,
               response.statusCode == 200,
               let data = data {
                completion(.success(data))
            } else {
                completion(.failure(SearchServiceError.invalidUrl))
            }
        }
        
        task.resume()
    }
    
    
    private func download(from url: URL, completion: @escaping (Result<URL, Error>) -> Void) {
        let task = URLSession.shared.downloadTask(with: url) { url, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            if let response = response as? HTTPURLResponse,
               response.statusCode == 200,
               let url = url {
                completion(.success(url))
            } else {
                completion(.failure(SearchServiceError.invalidUrl))
            }
        }
        
        task.resume()
    }
    
    
    private func convertResponseToModel(response: SearchResultResponse) -> SearchResultModel {
        return SearchResultModel(id: response.trackId,
                                 artistName: response.artistName,
                                 trackName: response.trackName,
                                 imageUrl: URL(string: response.artworkUrl100 ?? ""),
                                 previewUrl: URL(string: response.previewUrl)!)
    }
}
