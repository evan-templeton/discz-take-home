//
//  SearchView.swift
//  DisczTakeHome
//
//  Created by Evan Templeton on 8/6/22.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                SearchBarView(searchTerm: $viewModel.searchTerm,
                              placeholderText: Constants.searchPlaceholderText,
                              cancelButtonText: Constants.cancelButtonText)
                
                SearchListView(viewModel: viewModel)
            }
            .onTapGesture {
                endEditing()
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(Constants.findSongs)
                    .foregroundColor(.white)
                    .font(.grifterBoldTitle)
            }
        }
        .alert(viewModel.selectedResult?.trackName ?? Constants.songPlaying,
               isPresented: $viewModel.shouldPlayAudio) {
            Button(Constants.stop, role: .cancel) {}
        }
        .alert(viewModel.errorMessage,
               isPresented: $viewModel.shouldShowError) {
            Button(Constants.OK, role: .cancel) {}
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel())
    }
}
