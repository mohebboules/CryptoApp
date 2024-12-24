//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by Moheb Boules on 22/12/2024.
//

import SwiftUI

struct PortfolioView: View {
    @Binding var showPortfolioView: Bool
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
                .navigationTitle("Edit Portfolio")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        XMarkButton(showView: $showPortfolioView)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        trailingNavBarButtons
                    }
                }
                .onChange(of:vm.searchText , {
                    if vm.searchText == "" {
                        removeSelectedCoin()
                    }
                })
            }
            .background(Color.theme.background.ignoresSafeArea())
        }
    }
}

#Preview {
    PortfolioView(showPortfolioView: .constant(false))
        .environmentObject(DeveloperPreview.dev.homeVm)
}

extension PortfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal,showsIndicators: false){
            LazyHStack(spacing: 10) {
                ForEach(vm.searchText.isEmpty ? vm.portofolioCoins : vm.allCoins) { coin in
                    coinButton(coin: coin)
                }
            }
            .frame(height: 120)
            .padding(.leading)
        }
    }
    
    private var portfolioInputSection: some View {
        withAnimation(.none){
            VStack(spacing: 20) {
                HStack {
                    Text("The current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                    Spacer()
                    Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
                }
                Divider()
                HStack{
                    Text("Amount holding")
                    Spacer()
                    TextField("Ex: 1.4", text: $quantityText)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                }
                Divider()
                HStack{
                    Text("Current value")
                    Spacer()
                    Text(getCurrentValue().asCurrencyWith2Decimals())
                }
            }
        }
        
        .padding(.vertical)
    }
    
    private var trailingNavBarButtons: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1 : 0)
            Button {
                savedButtonPressed()
            } label: {
                Text("Save".uppercased())
            }
            .opacity(selectedCoin != nil &&
                     selectedCoin?.currentHoldings != Double(quantityText) ? 1 : 0)

        }
        .font(.headline)
    }
    
    private func coinButton(coin: CoinModel) -> some View {
        CoinLogoView(coin: coin)
            .frame(width: 75)
            .padding(4)
            .onTapGesture {
                withAnimation(.easeIn){
                    updateSelectedCoin(coin: coin)
                    UIApplication.shared.endEditing()
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        selectedCoin?.id == coin.id ? Color.theme.green : Color.clear,
                        lineWidth: 1)
            )
    }
    
    private func updateSelectedCoin(coin: CoinModel){
        selectedCoin = coin
        
        if let portfolioCoin = vm.portofolioCoins.first(where: { $0.id == coin.id }),
        let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
        
        
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText){
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func savedButtonPressed(){
        guard let coin = selectedCoin,
              let amount = Double(quantityText)
        else { return }
        
        // Save to porfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        // Show Checkmark
        withAnimation(.easeIn){
            showCheckmark = true
            removeSelectedCoin()
        }
        
        // Hide keyboard
        UIApplication.shared.endEditing()
        
        // Hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
    }
    
    private func removeSelectedCoin(){
        selectedCoin = nil
        vm.searchText = ""
    }
    
}
