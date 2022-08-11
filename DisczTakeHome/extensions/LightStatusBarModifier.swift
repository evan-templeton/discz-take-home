//
//  LightStatusBarModifier.swift
//  DisczTakeHome
//
//  Created by Evan Templeton on 8/9/22.
//

import SwiftUI

/**
 A ViewModifier to change the status bar's color (time, wifi, connection strength at the top of the phone)
 This appears to be the most "acceptable" way to do this as of 08/22
 */
struct LightStatusBarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onAppear {
                UIApplication.shared.statusBarStyle = .lightContent
            }
            .onDisappear {
                UIApplication.shared.statusBarStyle = .default
            }
    }
}

extension View {
    func enableLightStatusBar() -> some View {
        self.modifier(LightStatusBarModifier())
    }
}
