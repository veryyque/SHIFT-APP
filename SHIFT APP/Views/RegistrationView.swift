//
//  RegistrationView.swift
//  SHIFT APP
//
//  Created by Вероника Москалюк on 06.04.2026.
import SwiftUI

struct RegistrationView: View {
    @StateObject private var viewModel = RegistrationViewModel()
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {

                    VStack(spacing: 8) {
                        Image(systemName: "person.badge.plus")
                            .font(.system(size: 60))
                            .foregroundColor(Color(hex: "#0E6973"))
                        Text("Регистрация")
                            .font(.title)
                            .bold()
                        Text("Создайте новый аккаунт")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 40)
                    

                    VStack(spacing: 16) {
                        
                        VStack(alignment: .leading, spacing: 4) {
                            TextField("Имя", text: $viewModel.firstName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.words)
                            
                            if !viewModel.firstNameError.isEmpty {
                                Text(viewModel.firstNameError)
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            TextField("Фамилия", text: $viewModel.lastName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.words)
                            
                            if !viewModel.lastNameError.isEmpty {
                                Text(viewModel.lastNameError)
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                        }
                        
                        DatePicker("Дата рождения",
                                  selection: $viewModel.birthDate,
                                  in: ...Date(),
                                  displayedComponents: .date)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            SecureField("Пароль", text: $viewModel.password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            if !viewModel.passwordError.isEmpty {
                                Text(viewModel.passwordError)
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            SecureField("Подтвердите пароль", text: $viewModel.confirmPassword)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            if !viewModel.confirmPasswordError.isEmpty {
                                Text(viewModel.confirmPasswordError)
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    

                    Button(action: {
                        viewModel.register()
                    }) {
                        Text("Зарегистрироваться")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(viewModel.isRegisterButtonEnabled ? Color(hex: "#FFD500") : Color.gray)
                            .foregroundColor(viewModel.isRegisterButtonEnabled ? Color(hex: "#0E6973") : Color.white)
                            .cornerRadius(10)
                    }
                    .disabled(!viewModel.isRegisterButtonEnabled)
                    .padding(.horizontal, 24)
                    
                    Spacer(minLength: 40)
                }
            }
            .navigationBarHidden(true)
            .alert("Ошибка", isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.alertMessage)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .userDidRegister)) { _ in
            isLoggedIn = true
        }
    }
}

#if DEBUG
struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RegistrationView()
                .previewDisplayName("iPhone 17 Pro")
                .previewDevice("iPhone 17 Pro")
        }
    }
}
#endif



