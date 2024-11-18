//
//  Untitled.swift
//  Assignment
//
//  Created by Neha Jain on 18/11/24.
//

import Foundation

class ReadJsonDataFromMockFiles {
    static let shared = ReadJsonDataFromMockFiles()
    
    private init() {}
    
    func getJsonToModel<T: Codable>(fileName: String) -> T? {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json") else {
            return nil
        }

        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: filePath))
            let model = try JSONDecoder().decode(T.self, from: jsonData)
            return model
        } catch {
            debugPrint(error)
        }
        return nil
    }
}
