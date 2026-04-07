//
//  Product.swift
//  SHIFT APP
//
//  Created by Вероника Москалюк on 06.04.2026.
//
import Foundation

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Double
}
