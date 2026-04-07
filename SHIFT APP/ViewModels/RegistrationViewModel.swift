//
//  RegistrationViewModel.swift
//  SHIFT APP
//
//  Created by Вероника Москалюк on 06.04.2026.
//
import SwiftUI
import Combine

class RegistrationViewModel: ObservableObject {
    
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var birthDate = Date()
    @Published var password = ""
    @Published var confirmPassword = ""
    
    @Published var firstNameError = ""
    @Published var lastNameError = ""
    @Published var birthDateError = ""
    @Published var passwordError = ""
    @Published var confirmPasswordError = ""
    @Published var isRegisterButtonEnabled = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    private let validation = ValidationService()
    private let storage = StorageService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupValidation()
    }
    
    private func setupValidation() {
       
        $firstName
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] name in
                self?.firstNameError = self?.validation.isNameValid(name) == true ? "" : "Минимум 2 символа"
                self?.updateButtonState()
            }
            .store(in: &cancellables)
        
        $lastName
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] name in
                self?.lastNameError = self?.validation.isNameValid(name) == true ? "" : "Минимум 2 символа"
                self?.updateButtonState()
            }
            .store(in: &cancellables)
        
        $birthDate
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] date in
                self?.birthDateError = self?.validation.isAgeValid(birthDate: date) == true ? "" : "Вам должно быть 18 лет или больше"
                self?.updateButtonState()
            }
            .store(in: &cancellables)
        
        $password
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] pass in
                self?.passwordError = self?.validation.isPasswordValid(pass) == true ? "" : "Пароль: минимум 6 символов, цифра и заглавная буква"
                self?.updateButtonState()
            }
            .store(in: &cancellables)
        
        Publishers.CombineLatest($password, $confirmPassword)
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] pass, confirm in
                if !confirm.isEmpty {
                    self?.confirmPasswordError = self?.validation.doPasswordsMatch(pass, confirm) == true ? "" : "Пароли не совпадают"
                } else {
                    self?.confirmPasswordError = ""
                }
                self?.updateButtonState()
            }
            .store(in: &cancellables)
    }
    
    private func updateButtonState() {
        isRegisterButtonEnabled =
            validation.isNameValid(firstName) &&
            validation.isNameValid(lastName) &&
            validation.isPasswordValid(password) &&
            validation.doPasswordsMatch(password, confirmPassword)

    }
    
    func register() {

        guard validation.isAgeValid(birthDate: birthDate) else {
            birthDateError = "Вам должно быть 18 лет или больше"
            alertMessage = "Вам должно быть 18 лет или больше"
            showAlert = true
            return
        }
        birthDateError = ""

        storage.saveUserName(firstName)

        NotificationCenter.default.post(name: .userDidRegister, object: nil)
    }
}
