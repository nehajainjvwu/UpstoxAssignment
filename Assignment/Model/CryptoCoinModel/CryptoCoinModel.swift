//
//  Untitled.swift
//  Assignment
//
//  Created by Neha Jain on 14/11/2024.
//

//MARK: Response Model
struct CryptoCoinModel: Codable {
    let name: String?
    let symbol: String?
    let type: String?
    let isActive: Bool?
    let isNew: Bool?
    
    enum CodingKeys: String, CodingKey {
        case name
        case symbol
        case type
        case isActive = "is_active"
        case isNew = "is_new"
    }
}

//MARK: Filter Model
struct FilterOptionStruct {
    var name: String
    var isActive: Bool
    var isNew: Bool
    var type: String
}

//MARK: Filter Option Enum
enum CoinFilterType: String {
    case inactiveCoin = "Inactive Coins"
    case activeCoin = "Active Coins"
    case onlytoken = "Only Tokens"
    case onlyCoin = "Only Coins"
    case newCoin = "New Coins"
}
