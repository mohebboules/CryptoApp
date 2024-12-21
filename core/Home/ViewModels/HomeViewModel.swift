//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Moheb Boules on 21/12/2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portofolioCoins: [CoinModel] = []
    
    @Published var searchText: String = ""
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let dataService = CoinDataService()
    
    init(){
        addSubscribers()
    }
    
    func addSubscribers(){
        // If no search was implemented
        /*
        dataService.$allCoins
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
         */
        // Updates all coins (no need for the dataservice code due to the usage of combineLatest)
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
           
    }
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel]{
        guard !text.isEmpty else { return coins }
        let lowercasedText = text.lowercased()
        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
}
