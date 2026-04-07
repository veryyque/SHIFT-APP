//
//  ProductCell.swift
//  SHIFT APP
//
//  Created by Вероника Москалюк on 06.04.2026.
import SwiftUI

struct ProductCell: View {
    let product: Product
    
    var body: some View {
        HStack(spacing: 16) {
            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color(hex: "#0E6973"),
                            Color(hex: "#FFD500")
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 50, height: 50)
                .overlay(
                    Image(systemName: "bag.fill")
                        .foregroundColor(.white)
                        .font(.title3)
                )
            
            VStack(alignment: .leading, spacing: 6) {
                Text(product.title)
                    .font(.system(size: 16, weight: .medium))
                    .lineLimit(2)
                    .foregroundColor(.primary)
                
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color(hex: "#0E6973"))
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(Color(hex: "#FFD500").opacity(0.8))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: Color(hex: "#FFD500").opacity(0.3), radius: 4, x: 0, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(hex: "#0E6973").opacity(0.5), lineWidth: 1)
        )
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: 
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
#if DEBUG
struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductCell(product: Product(
            id: 1,
            title: "Пример товара с длинным названием для проверки",
            price: 99.99
        ))
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
#endif
