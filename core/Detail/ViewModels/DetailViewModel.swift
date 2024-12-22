//
//  DetailViewModel.swift
//  CryptoApp
//
//  Created by Moheb Boules on 22/12/2024.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    private let coinDetailService: CoinDetailDataService
    private var cancellables: Set<AnyCancellable> = []
    
    init(coin: CoinModel){
        self.coinDetailService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers(){
        coinDetailService.$coinDetails
            .sink { returnedCoinDetails in
                print("Received coin details")
                print(returnedCoinDetails)
            }
            .store(in: &cancellables)
        
    }

    
}
