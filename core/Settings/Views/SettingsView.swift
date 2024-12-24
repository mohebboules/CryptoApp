//
//  SettingsView.swift
//  CryptoApp
//
//  Created by Moheb Boules on 24/12/2024.
//

import SwiftUI

struct SettingsView: View {
    @State var showView: Bool = false
  
    let defaultURL = URL(string: "https://www.google.com")
    let youtubeURL = URL(string: "https://www.youtube.com/c/swiftfulThinking")
    let coffeeURL = URL(string: "https://www.buymeacoffee.com/nicksarno")
    let coingeckoURL = URL(string: "https://www.coingecko.com")
    let personalURL = URL(string: "https://github.com/mohebboules")
    var body: some View {
        
        NavigationStack{
            ZStack{
                // Background layer
                Color.theme.background.ignoresSafeArea()
                // content layer
                List{
                    swiftfulThinkingSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    coinGeckoSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    developerSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    applicationSection
                        .listRowBackground(Color.theme.background.opacity(0.5))
                }
            }

            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton(showView: $showView)
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}

extension SettingsView {
    private var swiftfulThinkingSection: some View {
        Section(header: Text("Swiftful Thinking")){
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was made by following Swiftful Thinking course on YouTube. It uses MVVM Architecture, Combine and Core data")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            if let youtubeURL = youtubeURL, let coffeeURL = coffeeURL {
                Link("Subscribe on YouTube", destination: youtubeURL)
                Link("Support his coffee addiction", destination: coffeeURL)
            }
              
        }
        .accentColor(Color.blue)
        .font(.headline)
    }
    
    private var coinGeckoSection: some View {
        Section(header: Text("CoinGecko")){
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This Cryptocurrency API provides real-time data on cryptocurrency prices, market trends, and volumes comming from free API 'CoinGecko'. These data might be slightly delayed")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            if let coingeckoURL = coingeckoURL{
                Link("Visit coingecko", destination: coingeckoURL)
            }
              
        }
        .accentColor(Color.blue)
        .font(.headline)
    }
    
    private var developerSection: some View {
        Section(header: Text("Developer")){
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was developed by Moheb Boules. It uses SwiftUI and is written 100% in Swift. The project benfits from multi-threading, publishers/listeners, and data persistence. ")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            if let personalURL = personalURL{
                Link("Visit my Github account", destination: personalURL)
            }
              
        }
        .accentColor(Color.blue)
        .font(.headline)
    }
    private var applicationSection: some View {
        Section(header: Text("Application")){
         if let defaultURL = defaultURL{
                Link("Terms of service", destination: defaultURL)
                Link("Privacy policy", destination: defaultURL)
                Link("Company Website", destination: defaultURL)
                Link("Learn more", destination: defaultURL)
             
            }
              
        }
        .accentColor(Color.blue)
        .font(.headline)
    }
}
