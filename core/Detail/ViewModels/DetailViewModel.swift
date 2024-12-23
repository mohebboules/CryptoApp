//
//  DetailViewModel.swift
//  CryptoApp
//
//  Created by Moheb Boules on 22/12/2024.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var overviewStatistics: [StatisticModel] = []
    @Published var AdditionalStatistics: [StatisticModel] = []

    
    private let coinDetailService: CoinDetailDataService
    private var cancellables: Set<AnyCancellable> = []
    @Published var coin: CoinModel
    
    init(coin: CoinModel){
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.coin = coin
        addSubscribers()
    }
    
    private func addSubscribers(){
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] returnedArrays in
                self?.overviewStatistics = returnedArrays.overview
                self?.AdditionalStatistics = returnedArrays.additional
            }
            .store(in: &cancellables)
        
    }

    private func mapDataToStatistics(coinDatailModel: CoinDetailModel?, coinModel: CoinModel) -> ( overview: [StatisticModel], additional: [StatisticModel]) {
        // Overview
        let overviewArray = createOverviewArray(coinModel: coinModel)

        // Additional
        let additionalArray = createAdditionalArray(coinDatailModel: coinDatailModel, coinModel: coinModel)
        
        return (overviewArray, additionalArray)
    }
    
    private func createOverviewArray(coinModel: CoinModel) -> [StatisticModel] {
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentChange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Cap", value: marketCap, percentageChange: marketCapPercentChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volume)
        
        let overviewArray: [StatisticModel] = [priceStat, marketCapStat, rankStat, volumeStat]
        return overviewArray
    }
    
    private func createAdditionalArray(coinDatailModel: CoinDetailModel?, coinModel: CoinModel) -> [StatisticModel] {
        let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? ""
        let highStat = StatisticModel(title: "24H High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? ""
        let lowStat = StatisticModel(title: "24H Low", value: low)
        
        let priceChange = coinModel.priceChangePercentage24H?.asCurrencyWith6Decimals() ?? ""
        let pricePercentChange2 = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24H Price Change", value: priceChange, percentageChange: pricePercentChange2)
        
        let marketCapChange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange2 = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(title: "24H Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange2)
        
        let blockTime = coinDatailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "N/A" : "\(blockTime)"
        let blockTimeStat = StatisticModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDatailModel?.hashingAlgorithm ?? "N/A"
        let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
        
        let additionalArray: [StatisticModel] = [highStat, lowStat, priceChangeStat, marketCapChangeStat, blockTimeStat, hashingStat]
        
        return additionalArray
    }
    
}
