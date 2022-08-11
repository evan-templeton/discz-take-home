//
//  SearchListView.swift
//  DisczTakeHome
//
//  Created by Evan Templeton on 8/9/22.
//

import SwiftUI

struct SearchListView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.searchResults) { result in
                    Button {
                        viewModel.selectedResult = result
                    } label: {
                        SearchRowItemView(item: result,
                                          imageData: viewModel.getImageData(result.imageUrl))
                    }
                }
            }
        }
    }
}

struct SearchListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchListView(viewModel: SearchViewModel())
    }
}
