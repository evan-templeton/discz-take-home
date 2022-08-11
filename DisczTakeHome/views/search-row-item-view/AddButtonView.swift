//
//  AddButtonView.swift
//  DisczTakeHome
//
//  Created by Evan Templeton on 8/10/22.
//

import SwiftUI

struct AddButtonView: View {
    var body: some View {
        ZStack {
            Image(systemName: "plus.circle")
                .resizable()
                .foregroundColor(.electricBlue)
                .blur(radius: 1)
            Image(systemName: "plus.circle")
                .resizable()
                .foregroundColor(.electricBlue)
        }
    }
}

struct AddButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            SearchRowItemView(item: .testModels()[0], imageData: nil)
        }
    }
}
