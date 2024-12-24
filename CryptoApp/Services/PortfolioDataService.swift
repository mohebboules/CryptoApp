//
//  PortfolioDataService.swift
//  CryptoApp
//
//  Created by Moheb Boules on 22/12/2024.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    init(){
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading core data \(error)")
            }
        }
        self.getPortfolio()
    }
    
    // MARK: Public functions
    func updatePortfolio(coin: CoinModel, amount: Double){
        
        // Check if coin is already in portfolio
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }){
            if amount > 0 {
                update(entity: entity, amount: amount)
            }
            else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    // MARK: Private functions
    private func getPortfolio(){
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        }
        catch let error {
            print("Error fetching portfolio \(error)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double){
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func save(){
        do{
            try container.viewContext.save()
        }
        catch let error {
            print("Error saving portfolio \(error)")
        }
    }
    
    private func applyChanges(){
        save()
        getPortfolio()
    }
    
    private func update(entity: PortfolioEntity, amount: Double){
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: PortfolioEntity){
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    
    
    
    
}
