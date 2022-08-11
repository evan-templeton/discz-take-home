//
//  ContentView.swift
//  DisczTakeHome
//
//  Created by Evan Templeton on 8/3/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        NavigationView {
            SearchView(viewModel: viewModel)
                .enableLightStatusBar()
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: SearchViewModel(searchService: SearchService()))
    }
}
