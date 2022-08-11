//
//  View+UIApplication.swift
//  DisczTakeHome
//
//  Created by Evan Templeton on 8/10/22.
//

import SwiftUI

extension View {
    public func endEditing() {
        UIApplication.shared.endEditing()
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
