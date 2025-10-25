//
//  SongRowCell.swift
//  SwiftfulSwiftUIInPractice
//
//  Created by Tirzaan on 10/23/25.
//

import SwiftUI

struct SongRowCell: View {
    var imageSize: CGFloat = 50
    var imageName: String = Constants.randomImage
    var title: String = "Song Title"
    var subtitle: String? = "Song Description"
    var onCellPressed: (() -> Void)? = nil
    var onEllipsisPressed: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 8) {
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.spotitfiyWhite)
                Text(subtitle ?? "")
                    .font(.callout)
                    .foregroundColor(.spotitfiyLightGray)
            }
            .lineLimit(2)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "ellipsis")
                .font(.subheadline)
                .foregroundStyle(.spotitfiyLightGray)
                .padding(16)
                .background(.spotitfiyBlack.opacity(0.001))
                .onTapGesture {
                    onEllipsisPressed?()
                }
        }
        .background(.spotitfiyBlack.opacity(0.001))
        .onTapGesture {
            onCellPressed?()
        }
    }
}

#Preview {
    ZStack {
        Color.spotitfiyBlack.ignoresSafeArea()
        
        VStack {
            SongRowCell()
            SongRowCell()
            SongRowCell()
            SongRowCell()
            SongRowCell()
        }
    }
}
