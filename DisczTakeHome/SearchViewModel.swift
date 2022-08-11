//
//  SearchViewModel.swift
//  DisczTakeHome
//
//  Created by Evan Templeton on 8/3/22.
//

import SwiftUI
import AVFoundation

final class SearchViewModel: ObservableObject {
    private let searchService: SearchServiceProtocol
    private var player: AVAudioPlayer?
    
    @Published var searchTerm = "" {
        didSet { search() }
    }
    @Published var searchResults = [SearchResultModel]()
    @Published var imagesData = [URL: Data]()
    @Published var didFinishLoadingResults = false
    @Published var noResultsFound = false
    private var resultIds = [Int: Int]()
    
    public var selectedResult: SearchResultModel? {
        didSet { downloadAndPlayAudio() }
    }
    
    @Published var shouldPlayAudio = false {
        didSet { handleAudio() }
    }
    
    public var errorMessage = ""
    @Published var shouldShowError = false
    
    // MARK: - Initialization
    init(searchService: SearchServiceProtocol) {
        self.searchService = searchService
    }
    
    
    convenience init() {
        self.init(searchService: SearchService())
    }
    
    
    // MARK: - Search Methods
    private func search() {
        guard !self.searchTerm.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return resetSearch()
        }
        
        self.didFinishLoadingResults = false
        
        self.searchService.fetchResults(with: searchTerm) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    self.handleSearchResults(results)
                case .failure(let error):
                    self.handleError(error)
                }
            }
        }
    }
    
    
    private func handleSearchResults(_ results: [SearchResultModel]) {
        guard results.count > 0 else {
            return self.noResultsFound = true
        }
        
        resetSearch()

        // iTunes Search API often returns duplicates
        // remove duplicates by id.
        var newResults = [SearchResultModel]()
        
        for item in results where resultIds[item.id] != item.id {
            resultIds[item.id] = item.id
            newResults.append(item)
            if let url = item.imageUrl {
                fetchImage(url: url)
            }
        }

        guard newResults.count > 0 else { return }

        searchResults = newResults
        self.didFinishLoadingResults = true
    }
    
    
    private func fetchImage(url: URL) {
        guard imagesData[url] == nil else { return }
        
        searchService.fetchImage(from: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if !data.isEmpty {
                        self.imagesData[url] = data
                    }
                case .failure(let error):
                    self.handleError(error)
                }
            }
        }
    }
    
    
    private func resetSearch() {
        self.searchResults = []
        self.resultIds = [:]
    }
    
    
    // MARK: - Audio Methods
    private func downloadAndPlayAudio() {
        guard let selectedResult = self.selectedResult else { return }

        self.searchService.downloadAudio(from: selectedResult.previewUrl) { result in
            switch result {
            case .success(let url):
                self.playAudio(from: url)
            case .failure:
                self.handleError(SearchServiceError.download)
            }
        }
    }
    
    
    private func playAudio(from url: URL) {
        do {
            self.player = try AVAudioPlayer(contentsOf: url)
            // Enables playback if device is on silent
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            DispatchQueue.main.async {
                self.shouldPlayAudio = true
            }
        } catch {
            self.handleError(SearchServiceError.audio)
        }
    }
    
    
    private func handleAudio() {
        if self.shouldPlayAudio {
            self.player?.play()
        } else {
            self.player?.stop()
        }
    }
    
    
    // MARK: - Error Handling
    private func handleError(_ error: Error) {
        DispatchQueue.main.async {
            self.errorMessage = error.localizedDescription
            self.shouldShowError = true
        }
    }
    
    
    // MARK: - Public Methods
    /** Called by SearchListView to populate an image. Either returns cached image data item from self.imagesData, or an empty Data object */
    public func getImageData(_ url: URL?) -> Data {
        if let url = url {
            return imagesData[url] ?? Data()
        } else {
            return Data()
        }
    }
}
