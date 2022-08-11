//
//  ITunesAPIResponse.swift
//  DisczTakeHome
//
//  Created by Evan Templeton on 8/9/22.
//

import Foundation

public struct ITunesAPIResponse: Codable {
    var results: [SearchResultResponse]
}

public struct SearchResultResponse: Codable {
    let trackId: Int
    let artistName: String
    let trackName: String
    let artworkUrl100: String?
    let previewUrl: String
}
