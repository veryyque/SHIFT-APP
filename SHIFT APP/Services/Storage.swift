//
//  Storage.swift
//  SHIFT APP
//
//  Created by Вероника Москалюк on 06.04.2026.
//

import Foundation

class StorageService {
    private let defaults = UserDefaults.standard
    
    func saveUserName(_ name: String) {
        defaults.set(name, forKey: "userName")
    }
    
    func getUserName() -> String {
        return defaults.string(forKey: "userName") ?? "Гость"
    }
    
    func saveLoginState(_ isLogged: Bool) {
        defaults.set(isLogged, forKey: "isLoggedIn")
    }
}
