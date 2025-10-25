//
//  SpotifiyRecentsCell.swift
//  SwiftfulSwiftUIInPractice
//
//  Created by Tirzaan on 10/22/25.
//

import SwiftUI

struct SpotifiyRecentsCell: View {
    var imageName: String = Constants.randomImage
    var title: String = "Song Title"
    
    var body: some View {
        HStack(spacing: 16) {
            ImageLoaderView(urlString: imageName)
                .frame(width: 55, height: 55)
            
            Text(title)
                .font(.callout)
                .fontWeight(.semibold)
                .lineLimit(2)
        }
        .padding(.trailing, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .themeColors(isSelected: false)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

#Preview {
    ZStack {
        Color.spotitfiyBlack.ignoresSafeArea()
        
        VStack {
            HStack {
                SpotifiyRecentsCell()
                SpotifiyRecentsCell()
            }
            HStack {
                SpotifiyRecentsCell()
                SpotifiyRecentsCell()
            }
        }
    }
}
