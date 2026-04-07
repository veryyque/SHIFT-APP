//
//  Network.swift
//  SHIFT APP
//
//  Created by Вероника Москалюк on 06.04.2026.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkService {
    
    func fetchProducts(completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(products))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
