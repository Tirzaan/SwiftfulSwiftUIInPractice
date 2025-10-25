//
//  ImageTitleRowCell.swift
//  SwiftfulSwiftUIInPractice
//
//  Created by Tirzaan on 10/23/25.
//

import SwiftUI

struct ImageTitleRowCell: View {
    var imageName: String = Constants.randomImage
    var title: String = "Title"
    var imageSize: CGFloat = 100
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)

            Text(title)
                .font(.callout)
                .foregroundStyle(.spotitfiyLightGray)
                .lineLimit(2)
                .padding(4)
        }
        .frame(width: imageSize)
    }
}

#Preview {
    ZStack {
        Color.spotitfiyBlack.ignoresSafeArea()
        
        ImageTitleRowCell()
    }
}
