//
//  Validation.swift
//  SHIFT APP
//
//  Created by Вероника Москалюк on 06.04.2026.
//

import Foundation

class ValidationService {
    
    func isNameValid(_ name: String) -> Bool {
        let trimmed = name.trimmingCharacters(in: .whitespaces)
        return trimmed.count >= 2
    }
    
    func isPasswordValid(_ password: String) -> Bool {
        let hasUppercase = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        let hasDigit = password.rangeOfCharacter(from: .decimalDigits) != nil
        return password.count >= 6 && hasUppercase && hasDigit
    }
    
    func doPasswordsMatch(_ password: String, _ confirm: String) -> Bool {
        return !password.isEmpty && password == confirm
    }
    
    func isAgeValid(birthDate: Date) -> Bool {
        let calendar = Calendar.current
        let age = calendar.dateComponents([.year], from: birthDate, to: Date()).year ?? 0
        return age >= 18
    }
}
