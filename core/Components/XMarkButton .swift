//
//  XMarkButton .swift
//  CryptoApp
//
//  Created by Moheb Boules on 22/12/2024.
//

import SwiftUI

struct XMarkButton: View {

    @Binding var showView: Bool

    var body: some View {
        Button(action: {
            showView.toggle()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

#Preview {
    XMarkButton(showView: .constant(false))
        .environmentObject(HomeViewModel())
}
