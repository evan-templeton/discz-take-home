//
//  SearchResultModel.swift
//  DisczTakeHome
//
//  Created by Evan Templeton on 8/9/22.
//

import Foundation

public struct SearchResultModel: Identifiable {
    public let id: Int
    let artistName: String
    let trackName: String
    let imageUrl: URL?
    let previewUrl: URL
}

extension SearchResultModel {
    static let testNames = ["Love's In Need of Love Today",
                            "Village Ghetto Land",
                            "Sir Duke",
                            "Have a Talk with God"]
    
    static func testModel(trackName: String) -> SearchResultModel {
        return SearchResultModel(id: trackName.count,
                                 artistName: "Stevie Wonder",
                                 trackName: trackName,
                                 imageUrl: URL(string: "testImageUrl")!,
                                 previewUrl: URL(string: "testPreviewUrl")!)
    }
    
    static func testModels() -> [SearchResultModel] {
        return testNames.map {
            testModel(trackName: $0)
        }
    }
    
    static func testModelsWithDuplicate() -> [SearchResultModel] {
        var models = testNames.map {
            testModel(trackName: $0)
        }
        models.append(testModel(trackName: testNames[0]))
        
        return models
    }
}
