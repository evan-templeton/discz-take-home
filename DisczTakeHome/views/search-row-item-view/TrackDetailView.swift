//
//  TrackDetailView.swift
//  DisczTakeHome
//
//  Created by Evan Templeton on 8/10/22.
//

import SwiftUI

struct TrackDetailView: View {
    let item: SearchResultModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(item.trackName)
                .font(.grifterBold)
                .foregroundColor(.white)
                .frame(alignment: .top)
                .lineLimit(1)
            Text(item.artistName)
                .font(.avenirMedium12)
                .foregroundColor(.gray)
                .frame(alignment: .bottom)
                .lineLimit(1)
        }
    }
}

struct TrackDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            SearchRowItemView(item: .testModels()[0], imageData: nil)
        }
    }
}
