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
                NavigationView{
                    DetailView(coin: coin)
                }
            }
        }

    }
}

struct DetailView: View {
    
    @StateObject private var vm: DetailViewModel
    private let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    private let spacing: CGFloat = 30
    
    init(coin: CoinModel){
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        
    }
    var body: some View {
        ZStack {
            ScrollView{
                VStack(spacing: 20) {
                 Text("")
                        .frame(height: 100)
                    oveviewTitle
                    Divider()
                    overviewGrid
                    
                    additionalTitle
                    Divider()
                    additionalGrid
                }
                .padding()
            }
        }
        .navigationTitle("\(vm.coin.name)")
    }
}

#Preview {
    NavigationView{
        DetailView(coin: DeveloperPreview.dev.coin)
    }
}

extension DetailView {
    
    private var oveviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    private var overviewGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: []) {
            ForEach(vm.overviewStatistics){ stat in
                StatisticView(stat: stat)
            }
        }
    }
    
    private var additionalGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: []) {
            ForEach(vm.AdditionalStatistics){ stat in
                StatisticView(stat: stat)
            }
        }
    }
}
