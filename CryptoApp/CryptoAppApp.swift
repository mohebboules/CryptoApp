//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Moheb Boules on 21/12/2024.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    @StateObject private var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)

        }
    }
}
