//
//  HomeStatsView.swift
//  CryptoApp
//
//  Created by Moheb Boules on 22/12/2024.
//

import SwiftUI

struct HomeStatsView: View {
    @EnvironmentObject private var vm: HomeViewModel
//    @Binding var showPorfolio: Bool
    var body: some View {
        HStack {
            ForEach(vm.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: vm.viewState == .portfolioList ? .trailing : .leading)
    }
}

#Preview {
    HomeStatsView()
        .environmentObject(DeveloperPreview.dev.homeVm)
}
