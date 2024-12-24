//
//  CircleButtonAnimationView.swift
//  CryptoApp
//
//  Created by Moheb Boules on 21/12/2024.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    private var animate: Bool {
            homeVm.viewState == .portfolioList
        }
    @EnvironmentObject private var homeVm: HomeViewModel
    
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5)
            .scale(animate ? 1 : 0)
            .opacity(animate ? 0 : 1)
            .animation(animate ? Animation.easeInOut(duration: 1) : .none, value: animate)
    }
}

#Preview {
    CircleButtonAnimationView()
        .environmentObject(HomeViewModel())
        .frame(width: 100, height: 100)
        .foregroundStyle(Color.red)
}
