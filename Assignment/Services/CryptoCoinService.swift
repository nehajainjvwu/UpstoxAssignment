//
//  CryptoCoinService.swift
//  Assignment
//
//  Created by Neha Jain on 14/11/2024.
//

//MARK: Crypto Coin Protocol
protocol CryptoCoinServiceProtocol {
    func fetchCryptoCoins(completion: @escaping (Result<[CryptoCoinModel], Error>) -> Void)
}

class CryptoCoinService: CryptoCoinServiceProtocol {
    let apiService: APIServiceProtocol?
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    //MARK: Get Response From API
    func fetchCryptoCoins(completion: @escaping (Result<[CryptoCoinModel], Error>) -> Void) {
        self.apiService?.fetchDataFromServer(urlString: ApiPointConstant.ApiEndPoint().cryptoListAPI, completion: { (result: Result<[CryptoCoinModel], Error>) in
            switch result {
            case .success(_):
                completion(result)
            case .failure( _):
                completion(result)
            }
        })
    }
}
