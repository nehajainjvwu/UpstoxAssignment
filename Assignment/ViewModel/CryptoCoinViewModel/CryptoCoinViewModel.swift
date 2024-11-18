//
//  CryptoCoinViewModel.swift
//  Assignment
//
//  Created by Neha Jain on 14/11/2024.
//

import Foundation

class CryptoCoinViewModel {
    let cryptoCoinService: CryptoCoinServiceProtocol?
    var coinsArray: [CryptoCoinModel] = []
    var filteredCoinsArray: [CryptoCoinModel] = []
    var filters = [
        FilterOptionStruct(name: "Active Coins", isActive: true, isNew: false, type: "coin"),
        FilterOptionStruct(name: "New Coins", isActive: false, isNew: true, type: "coin"),
        FilterOptionStruct(name: "Inactive Coins", isActive: false, isNew: false, type: "coin"),
        FilterOptionStruct(name: "Only Tokens", isActive: false, isNew: false, type: "token"),
        FilterOptionStruct(name: "Only Coins", isActive: false, isNew: false, type: "coin")
    ]
    
    var selectedItems: Set<IndexPath> = []
    var selectedFilters = [FilterOptionStruct]()
    var onUpdate: (() -> Void)?
    var searchText = ""
    
    // Inject Crypto Service Protocol "It helps to make out code loos coupled"
    init(cryptoCoinService: CryptoCoinServiceProtocol = CryptoCoinService()) {
        self.cryptoCoinService = cryptoCoinService
    }
    
    func getCryptoCoin(completion: @escaping(Bool) -> Void) {
        self.cryptoCoinService?.fetchCryptoCoins(completion: {[weak self] result in
            switch result {
            case .success(let response):
                self?.coinsArray = response
                self?.filteredCoinsArray = response
                self?.onUpdate?()
                completion(true)
            case .failure(_):
                completion(false)
            }
        })
    }
    
    func cancelSearch() {
        filteredCoinsArray = coinsArray
        onUpdate?()
    }
    
    
    /// Filter Coin Array according to Filter option
    func filterCoins() {
        filteredCoinsArray = coinsArray.filter { coin in
            self.selectedFilters.contains { filter in
                guard let filterType = CoinFilterType(rawValue: filter.name) else {
                    print("Invalid filter type for name: \(filter.name)")
                    return false // Skip this filter if it doesn't match a valid type
                }
                switch filterType {
                case .activeCoin, .inactiveCoin:
                    return filter.isActive == coin.isActive && filter.type == coin.type
                case .onlytoken, .onlyCoin:
                    return filter.type == coin.type
                case .newCoin:
                    return filter.isNew == coin.isNew && filter.type == coin.type
                }
            }
        }
        onUpdate?()
    }
    
    /// Search Coin Array according to Search Text
    func searchCoin() {
        if !searchText.isEmpty {
            filteredCoinsArray = coinsArray.filter { coin in
                coin.name?.contains(searchText) ?? false || (coin.symbol?.contains(searchText)) ?? false
            }
            onUpdate?()
        }
    }
}


