//
//  HomeView.swift
//  CryptoApp
//
//  Created by Moheb Boules on 21/12/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolioView: Bool = false // new sheet
    
    @State private var selectedCoin: CoinModel? = nil
    @State private var showCoinDetails: Bool = false
    @State private var showSettings: Bool = false
    
    var body: some View {
        ZStack{
            // Background layer
            Color.theme.background.ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView(showPortfolioView: $showPortfolioView)
                        .environmentObject(vm)
                }
            
            // Content layer
            VStack{
                homeHeader
                HomeStatsView()
                SearchBarView(searchText: $vm.searchText)
                
                columnTitles
                
                if vm.viewState == .livePricesList {
                    allCoinsList
                    .transition(.move(edge: .leading))
                }
                if vm.viewState == .portfolioList {
                    ZStack(alignment: .top) {
                        if vm.portofolioCoins.isEmpty && vm.searchText.isEmpty{
                            portfolioEmptyText
                                
                        } else {
                            portfolioCoinsList
                        }
                    }
 
                        .transition(.move(edge: .trailing))
                }

                Spacer(minLength: 0)
            }
            .sheet(isPresented: $showSettings, content: { SettingsView(showView: $showSettings) })
            
        }
        .navigationDestination(isPresented: $showCoinDetails) {
            DetailLoadingView(coin: $selectedCoin)
        } 
        // if before iOS 16
        /*
//        .background(
//            NavigationLink(destination: DetailView(coin: $selectedCoin), isActive: $showCoinDetails) {
//                                EmptyView()
//                            }
//        )
         */
        
        

        
       
        
    }
}

#Preview {
    NavigationView{
        HomeView()
    }
    .navigationBarHidden(true)
    .environmentObject(HomeViewModel())

}

extension HomeView {
    
    private var homeHeader: some View {
        HStack{
            CircleButtonView(iconName: vm.viewState == .portfolioList ? "plus" : "info")
                .animation(.none, value: vm.viewState == .portfolioList)
                .background(CircleButtonAnimationView())
                .onTapGesture {
                    if vm.viewState == .portfolioList {
                        showPortfolioView.toggle()
                  }
                    else {
                        showSettings.toggle()
                    }
                }
            Spacer()
            Text(vm.viewState == .portfolioList ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
                .animation(.none, value: vm.viewState == .portfolioList)

            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: vm.viewState == .portfolioList ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()){
                        if vm.viewState == .portfolioList {
                            vm.viewState = .livePricesList
                        } else {
                            vm.viewState = .portfolioList
                        }

                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List{
            ForEach(vm.allCoins){ coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
                    .listRowBackground(Color.theme.background)
            }
            
        }
        .listStyle(PlainListStyle())
        .refreshable {
            vm.reloadData()
        }
    }
    
    private var portfolioCoinsList: some View {
        List{
            ForEach(vm.portofolioCoins){ coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
            
        }
        .listStyle(PlainListStyle())
        .refreshable {
            vm.reloadData()
        }
    }
    
    private var portfolioEmptyText: some View {
        Text("You have not added any coins to yor portfolio yet. Click on the + button to add coins")
            .font(.callout)
            .foregroundStyle(Color.theme.accent)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .padding(50)
    }
    
    private var columnTitles: some View {
        HStack{
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity(vm.sortOption == .rank ||
                             vm.sortOption == .rankReversed ? 1 : 0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            Spacer()
            if vm.viewState == .portfolioList {
                HStack(spacing: 4) {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity(vm.sortOption == .holdings ||
                                 vm.sortOption == .holdingsReversed ? 1 : 0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity(vm.sortOption == .price ||
                             vm.sortOption == .priceReversed ? 1 : 0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                    }
                }
            Button {
                    vm.reloadData()
                    

            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)
            .animation(vm.isLoading ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default, value: vm.isLoading)

        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
    
    private func segue(coin: CoinModel){
        selectedCoin = coin
        showCoinDetails.toggle()
    }
}
