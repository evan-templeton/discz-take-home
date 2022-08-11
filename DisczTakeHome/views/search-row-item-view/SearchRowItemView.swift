//
//  SearchRowItemView.swift
//  DisczTakeHome
//
//  Created by Evan Templeton on 8/9/22.
//

import SwiftUI

struct SearchRowItemView: View {
    let item: SearchResultModel
    let imageData: Data?
    
    var body: some View {
        HStack {
            TrackImageView(imageData: self.imageData)
            
            TrackDetailView(item: self.item)
                .frame(height: 36)
            
            Spacer()
            
            AddButtonView()
                .frame(width: 24, height: 24)
            
        }
        .frame(height: 52)
        .padding(8)
    }
}


struct SearchRowItem_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            VStack {
                ForEach(SearchResultModel.testNames, id: \.self) { title in
                    SearchRowItemView(item: .testModel(trackName: title),
                                      imageData: nil)
                }
            }
        }
    }
}
