//
//  SHIFT_APPApp.swift
//  SHIFT APP
//
//  Created by Вероника Москалюк on 06.04.2026.
//
// TestApp.swift
import SwiftUI

@main
struct MyApp: App {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                MainView()
            } else {
                RegistrationView()
            }
        }
    }
}
