//
//  CircleButtonAnimationView.swift
//  CryptoApp
//
//  Created by Moheb Boules on 21/12/2024.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5)
            .scale(animate ? 1 : 0)
            .opacity(animate ? 0 : 1)
            .onAppear {
                animate.toggle()
            }
            .animation(animate ? Animation.easeInOut(duration: 1) : .none, value: animate)
    }
}

#Preview {
    CircleButtonAnimationView(animate: .constant(true))
        .frame(width: 100, height: 100)
        .foregroundStyle(Color.red)
}
