//
//  TrackImageView.swift
//  DisczTakeHome
//
//  Created by Evan Templeton on 8/10/22.
//

import SwiftUI

struct TrackImageView: View {
    let imageData: Data?
    
    var body: some View {
        if let imageData = imageData,
           let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 36, height: 36)
        } else {
            ImagePlaceholderView()
        }
    }
}

struct TrackImageView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            SearchRowItemView(item: .testModels()[0], imageData: nil)
        }
    }
}
