//
//  CoinImageViewModel.swift
//  CryptoApp
//
//  Created by Moheb Boules on 21/12/2024.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let dataService:CoinImageService
    private let coin: CoinModel
    private var cancellables: Set<AnyCancellable> = []
    init(coin: CoinModel){
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscribers()
        self.isLoading = true
        
    }
    private func addSubscribers(){
        dataService.$image
            .sink { [weak self]_ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)

    }
}
