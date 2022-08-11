//
//  SearchServiceMock.swift
//  DisczTakeHome
//
//  Created by Evan Templeton on 8/9/22.
//

import Foundation
import XCTest

class SearchServiceMock: SearchServiceProtocol {
    public var shouldSucceed: Bool
    public var shouldReturnResults: Bool
    public var hasDuplicates: Bool
    
    init(shouldSucceed: Bool, shouldReturnResults: Bool, hasDuplicates: Bool) {
        self.shouldSucceed = shouldSucceed
        self.shouldReturnResults = shouldReturnResults
        self.hasDuplicates = hasDuplicates
    }
    
    
    func fetchResults(with searchTerm: String, completion: @escaping (Result<[SearchResultModel], Error>) -> Void) {
        var results = [SearchResultModel]()
        if self.shouldSucceed {
            if shouldReturnResults {
                results = hasDuplicates
                ? SearchResultModel.testModelsWithDuplicate()
                : SearchResultModel.testModels()
            }
            completion(.success(results))
        } else {
            completion(.failure(SearchServiceError.generic))
        }
    }
    
    
    func fetchImage(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        if self.shouldSucceed {
            completion(.success(Data()))
        } else {
            completion(.failure(SearchServiceError.generic))
        }
    }
    
    
    func downloadAudio(from url: URL, completion: @escaping (Result<URL, Error>) -> Void) {
        if self.shouldSucceed {
            completion(.success(URL(string: "testUrl")!))
        } else {
            completion(.failure(SearchServiceError.generic))
        }
    }
}
