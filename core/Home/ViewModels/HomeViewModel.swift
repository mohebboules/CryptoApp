//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Moheb Boules on 21/12/2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] = []
    
    @Published var allCoins: [CoinModel] = []
    @Published var portofolioCoins: [CoinModel] = []
    
    @Published var searchText: String = ""
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
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
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        // Updates market data model
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
            }
            .store(in: &cancellables)
        // Updates portfolio Coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map { (coinModels, PortfolioEntities) -> [CoinModel] in
                coinModels
                    .compactMap { (coin) -> CoinModel? in
                        guard let entity = PortfolioEntities.first(where: { $0.coinID == coin.id }) else { return nil }
                        return coin.updateHoldings(amount: entity.amount)
                    }
            }
            .sink { [weak self] returnedCoins in
                self?.portofolioCoins = returnedCoins
            }
            .store(in: &cancellables)
           
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double){
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
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
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?) -> [StatisticModel]{
           var stats: [StatisticModel] = []
           guard let data = marketDataModel else { return stats }
           let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24hUsd)
           let volume = StatisticModel(title: "24h Volume", value: data.volume)
           let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
           let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)
           stats.append(contentsOf: [marketCap, volume,btcDominance, portfolio])
           return stats
    }
    
}
