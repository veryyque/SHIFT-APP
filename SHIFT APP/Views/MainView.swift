//
//  MainView.swift
//  SHIFT APP
//
//  Created by Вероника Москалюк on 06.04.2026.


import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    @AppStorage("isLoggedIn") private var isLoggedIn = true
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    VStack(spacing: 16) {
                        ProgressView()
                            .scaleEffect(1.2)
                            .tint(Color(hex: "#0E6973"))
                        Text("Загрузка товаров...")
                            .foregroundColor(Color(hex: "#0E6973"))
                    }
                } else if !viewModel.errorMessage.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 50))
                            .foregroundColor(Color(hex: "#FFD500"))
                        Text(viewModel.errorMessage)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(hex: "#0E6973"))
                        Button("Повторить") {
                            viewModel.loadProducts()
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color(hex: "#0E6973"))
                    }
                    .padding()
                } else {
                    List(viewModel.products) { product in
                        ProductCell(product: product)
                            .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .refreshable {
                        viewModel.loadProducts()
                    }
                }
            }
            .navigationTitle("Товары")
            .toolbarColorScheme(.light, for: .navigationBar)
            .toolbarBackground(Color(hex: "#FFD500").opacity(0.1), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.showGreeting = true
                    }) {
                        HStack {
                            Image(systemName: "hand.wave")
                            Text("Привет")
                        }
                        .foregroundColor(Color(hex: "#0E6973"))
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isLoggedIn = false
                    }) {
                        HStack {
                            Image(systemName: "arrow.backward")
                            Text("Выйти")
                        }
                        .foregroundColor(Color(hex: "#0E6973"))
                    }
                }
            }
            .alert("Приветствие", isPresented: $viewModel.showGreeting) {
                Button("Спасибо!", role: .cancel) { }
            } message: {
                Text("Привет, \(viewModel.userName)! 👋🏼\nДобро пожаловать в магазин!")
            }
        }
        .onAppear {
            if viewModel.products.isEmpty {
                viewModel.loadProducts()
            }
        }
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
                .previewDisplayName("Светлая тема")
            
            MainView()
                .preferredColorScheme(.dark)
                .previewDisplayName("Тёмная тема")
        }
    }
}
#endif
