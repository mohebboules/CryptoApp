//
//  XMarkButton .swift
//  CryptoApp
//
//  Created by Moheb Boules on 22/12/2024.
//

import SwiftUI

struct XMarkButton: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var showView: Bool

    var body: some View {
        Button(action: {
           dismiss()
            showView.toggle()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

#Preview {
    XMarkButton(showView: .constant(false))
}
