//
//  SearchBarView.swift
//  DisczTakeHome
//
//  Created by Evan Templeton on 8/6/22.
//

import SwiftUI

struct SearchBarView: View {
    @FocusState var textFieldFocused: Bool
    @Binding var searchTerm: String
    
    public let placeholderText: String
    public let cancelButtonText: String
    
    var body: some View {
        HStack {
            InputView(textFieldFocused: self._textFieldFocused,
                      searchTerm: self.$searchTerm,
                      placeholderText: self.placeholderText)
            
            CancelButtonView(textFieldFocused: self._textFieldFocused,
                             searchTerm: self.$searchTerm,
                             buttonText: self.cancelButtonText)
        }
    }
}


struct InputView: View {
    @FocusState var textFieldFocused: Bool
    @Binding var searchTerm: String
    
    let placeholderText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundColor(.electricBlue)
            
            TextField("", text: self.$searchTerm)
                .placeholder(when: searchTerm.isEmpty) {
                    Text(self.placeholderText)
                        .font(.avenirMedium15)
                        .foregroundColor(.white)
                }
                .foregroundColor(.white)
                .accentColor(.electricBlue)
                .font(.avenirMedium15)
                .focused(self.$textFieldFocused)
                .disableAutocorrection(true)
                
            Spacer()
            
            if !searchTerm.isEmpty {
                Button {
                    searchTerm = ""
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(8)
        .frame(height: 35)
        .background(Color.lightPurple)
        .cornerRadius(4)
    }
}


struct CancelButtonView: View {
    @FocusState var textFieldFocused: Bool
    @Binding var searchTerm: String
    
    let buttonText: String
    
    var body: some View {
        if !self.searchTerm.isEmpty && self.textFieldFocused {
            Button(self.buttonText) {
                endEditing()
            }
            .frame(height: 35)
            .foregroundColor(.white)
            .font(.avenirHeavy16)
        }
    }
}


struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel())
    }
}
