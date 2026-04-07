//
//  MainViewModel.swift
//  SHIFT APP
//
//  Created by Вероника Москалюк on 06.04.2026.

import SwiftUI
import Combine

class MainViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var showGreeting = false
    
    private let network = NetworkService()
    private let storage = StorageService()
    
    var userName: String {
        return storage.getUserName()
    }
    
    func loadProducts() {
        isLoading = true
        errorMessage = ""
        
        network.fetchProducts { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let products):
                    self?.products = products
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        self?.errorMessage = "Неверный адрес"
                    case .noData:
                        self?.errorMessage = "Нет данных"
                    case .decodingError:
                        self?.errorMessage = "Ошибка обработки"
                    }
                }
            }
        }
    }
}
