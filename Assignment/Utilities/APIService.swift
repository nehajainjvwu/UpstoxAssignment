//
//  APIService.swift
//  Assignment
//
//  Created by Neha Jain on 14/11/2024.
//

import Foundation

//MARK: Protocol for API Service class
protocol APIServiceProtocol {
    func fetchDataFromServer<T: Decodable>(urlString: String ,completion: @escaping (Result<[T], Error>) -> Void)
}

class APIService: APIServiceProtocol {
    /// Fetch Data from Server with this Generic function
    /// Parameter: - URL String
    /// Needs to send a Data Model Type to retun the Data in the Given Model Format
    func fetchDataFromServer<T: Decodable>(urlString: String ,completion: @escaping (Result<[T], Error>) -> Void) {
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let dataModel = try JSONDecoder().decode([T].self, from: data)
                completion(.success(dataModel))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
