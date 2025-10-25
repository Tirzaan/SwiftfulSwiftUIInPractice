//
//  SpotifiyCategoryCell.swift
//  SwiftfulSwiftUIInPractice
//
//  Created by Tirzaan on 10/22/25.
//

import SwiftUI

struct SpotifiyCategoryCell: View {
    var title: String = "All"
    var isSelected: Bool = false
    
    var body: some View {
        Text(title)
            .font(.callout)
            .frame(minWidth: 35)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .themeColors(isSelected: isSelected)
            .clipShape(Capsule())
    }
}

extension View {
    func themeColors(isSelected: Bool) -> some View {
        self
            .background(isSelected ? .spotitfiyGreen : .spotitfiyDarkGray)
            .foregroundStyle(isSelected ? .spotitfiyBlack : .spotitfiyWhite)
    }
}

#Preview {
    ZStack {
        Color.spotitfiyBlack.ignoresSafeArea()
        
        VStack(spacing: 40) {
            SpotifiyCategoryCell(isSelected: true)
            SpotifiyCategoryCell(title: "Music", isSelected: true)
            SpotifiyCategoryCell(title: "Podcasts")
        }
    }
}
