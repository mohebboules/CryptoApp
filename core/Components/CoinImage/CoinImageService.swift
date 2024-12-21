//
//  CoinImageService.swift
//  CryptoApp
//
//  Created by Moheb Boules on 21/12/2024.
//

import Foundation
import Combine
import SwiftUI

class CoinImageService {
    @Published var image: UIImage? = nil
    private var imageSubscribtion: AnyCancellable?
    private let coin: CoinModel
    init(coin: CoinModel){
        self.coin = coin
        getCoinImage()
    }
    private func getCoinImage(){
        guard let url = URL(string: coin.image) else { return }
        imageSubscribtion = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })

            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
                self?.imageSubscribtion?.cancel()
            })
        
    }
}
