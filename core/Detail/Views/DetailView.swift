//
//  DetailView.swift
//  CryptoApp
//
//  Created by Moheb Boules on 22/12/2024.
//

import SwiftUI

struct DetailLoadingView: View{
    
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }

    }
}

struct DetailView: View {
    let coin: CoinModel
    
    init(coin: CoinModel){
        self.coin = coin
    }
    var body: some View {
        ZStack {
            Text(coin.name)
            
        }

    }
}

#Preview {
    DetailView(coin: DeveloperPreview.dev.coin)
}
