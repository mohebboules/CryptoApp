//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Moheb Boules on 21/12/2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portofolioCoins: [CoinModel] = []
    init(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.allCoins.append(DeveloperPreview.dev.coin)
            self.portofolioCoins.append(DeveloperPreview.dev.coin)

        }
    }
}
