//
//  TextField+Placeholder.swift
//  DisczTakeHome
//
//  Created by Evan Templeton on 8/10/22.
//

import SwiftUI

/**
 A private method that adds placeholder text to a TextField. Takes in a Text View
 */
extension TextField {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
