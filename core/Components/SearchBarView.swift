//
//  SearchBarView.swift
//  CryptoApp
//
//  Created by Moheb Boules on 21/12/2024.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var body: some View {
       HStack {
            Image(systemName: "magnifyingglass")
               .foregroundStyle(
                searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent
               )
           TextField("Search by name or symbol...", text: $searchText)
               .foregroundStyle(Color.theme.accent)
               .disableAutocorrection(true)
               .submitLabel(.search)
               
               .overlay(
                Image(systemName: "xmark.circle.fill")
                    .padding()
                    .offset(x: 10)
                    .foregroundStyle(Color.theme.accent)
                    .opacity(searchText.isEmpty ? 0 : 1)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                        searchText = ""
                    }
                ,alignment: .trailing
               )
        }
       .font(.headline)
       .padding()
       .background(
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.theme.background)
            .shadow(color: Color.theme.accent.opacity(0.15), radius: 10, x: 0, y: 0)
       )
       .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
