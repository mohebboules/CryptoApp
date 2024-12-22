//
//  XMarkButton .swift
//  CryptoApp
//
//  Created by Moheb Boules on 22/12/2024.
//

import SwiftUI

struct XMarkButton: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var showPortfolioView: Bool

    var body: some View {
        Button(action: {
           dismiss()
            showPortfolioView.toggle()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

#Preview {
    XMarkButton(showPortfolioView: .constant(false))
}
