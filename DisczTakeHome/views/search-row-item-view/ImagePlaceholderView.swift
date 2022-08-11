//
//  ImagePlaceholderView.swift
//  DisczTakeHome
//
//  Created by Evan Templeton on 8/9/22.
//

import SwiftUI

struct ImagePlaceholderView: View {
    var body: some View {
        Rectangle()
            .fill(Color.darkPurple)
            .frame(width: 36, height: 36)
    }
}

struct ImagePlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePlaceholderView()
    }
}
