//
//  SearchViewModelTests.swift
//  DisczTakeHomeTests
//
//  Created by Evan Templeton on 8/10/22.
//

import XCTest
import SwiftUI
import Combine

class SearchViewModelTests: XCTestCase {
    private var viewModel: SearchViewModel!
    private var searchService: SearchServiceProtocol!
    
    private let searchTerm = "Hello"

    override func tearDown() {
        self.searchService = nil
        self.viewModel = nil
    }
    
    
    func test_search_succeedsWithResults() {
        loadViewModelWith(searchTerm: self.searchTerm,
                          shouldSucceed: true,
                          shouldReturnResults: true,
                          hasDuplicates: false)
        
        waitUntil(self.viewModel.$didFinishLoadingResults, equals: true, timeout: 1)
        
        XCTAssertEqual(self.viewModel.searchResults.count, SearchResultModel.testModels().count)
    }
    
    
    func test_search_succeedsWithNoResults() {
        loadViewModelWith(searchTerm: self.searchTerm,
                          shouldSucceed: true,
                          shouldReturnResults: false,
                          hasDuplicates: false)
        
        waitUntil(self.viewModel.$noResultsFound, equals: true, timeout: 1)
        
        XCTAssertEqual(self.viewModel.searchResults.count, 0)
    }
    
    
    func test_search_succeedsWithResults_noDuplicates() {
        loadViewModelWith(searchTerm: self.searchTerm,
                          shouldSucceed: true,
                          shouldReturnResults: true,
                          hasDuplicates: true)
        
        waitUntil(self.viewModel.$didFinishLoadingResults, equals: true, timeout: 1)
        
        XCTAssertEqual(self.viewModel.searchResults.count, SearchResultModel.testModelsWithDuplicate().count - 1)
    }
    
    
    func test_search_failsWithError() {
        loadViewModelWith(searchTerm: self.searchTerm,
                          shouldSucceed: false,
                          shouldReturnResults: false,
                          hasDuplicates: false)
        
        waitUntil(self.viewModel.$shouldShowError, equals: true)
        
        XCTAssertEqual(self.viewModel.errorMessage, SearchServiceError.generic.localizedDescription)
    }
    
    
    func test_downloadAndPlayAudio_failsWithError() {
        loadViewModelWith(searchTerm: self.searchTerm,
                          selectedResult: .testModel(trackName: "Hello"),
                          shouldSucceed: true,
                          shouldReturnResults: false,
                          hasDuplicates: false)
        
        waitUntil(self.viewModel.$shouldShowError, equals: true)
        
        XCTAssertEqual(self.viewModel.errorMessage, SearchServiceError.audio.localizedDescription)
    }
    
    
    private func loadViewModelWith(searchTerm: String, selectedResult: SearchResultModel? = nil, shouldSucceed: Bool, shouldReturnResults: Bool, hasDuplicates: Bool) {
        self.searchService = SearchServiceMock(shouldSucceed: shouldSucceed,
                                               shouldReturnResults: shouldReturnResults,
                                               hasDuplicates: hasDuplicates)
        
        self.viewModel = SearchViewModel(searchService: self.searchService)
        self.viewModel.searchTerm = searchTerm
        self.viewModel.selectedResult = selectedResult
    }
}


extension XCTestCase {
    func waitUntil<T: Equatable>(
        _ propertyPublisher: Published<T>.Publisher,
        equals expectedValue: T,
        timeout: TimeInterval = 5,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let expectation = expectation(
            description: "Awaiting value \(expectedValue)"
        )
        
        var cancellable: AnyCancellable?

        cancellable = propertyPublisher
            .dropFirst()
            .first(where: { $0 == expectedValue })
            .sink { value in
                XCTAssertEqual(value, expectedValue, file: file, line: line)
                cancellable?.cancel()
                expectation.fulfill()
            }

        waitForExpectations(timeout: timeout, handler: nil)
    }
}
