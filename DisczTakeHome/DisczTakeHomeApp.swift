//
//  DisczTakeHomeApp.swift
//  DisczTakeHome
//
//  Created by Evan Templeton on 8/3/22.
//

import SwiftUI

@main
struct DisczTakeHomeApp: App {
    @StateObject var viewModel = SearchViewModel(searchService: SearchService())
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
