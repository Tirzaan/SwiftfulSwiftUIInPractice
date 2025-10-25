//
//  PlaylistDesriptionCell.swift
//  SwiftfulSwiftUIInPractice
//
//  Created by Tirzaan on 10/23/25.
//

import SwiftUI

struct PlaylistDesriptionCell: View {
    var discriptionText: String = Product.mock.description
    var userName: String = "Tirzaan"
    var subheadline: String = "Playlist Subheadline"
    var onAddToPlaylistPressed: (() -> Void)? = nil
    var onDownloadPressed: (() -> Void)? = nil
    var onSharePressed: (() -> Void)? = nil
    var onEllipsisPressed: (() -> Void)? = nil
    var onShufflePressed: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(discriptionText)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            madeForYou
            
            Text(subheadline)
            
            buttonsRow
        }
        .font(.callout)
        .fontWeight(.medium)
        .foregroundStyle(.spotitfiyLightGray)
    }
    
    private var madeForYou: some View {
        HStack(spacing: 8) {
            Image(systemName: "applelogo")
                .font(.title3)
                .foregroundStyle(.spotitfiyGreen)
            
            Text("Made For \(Text(userName).bold().foregroundStyle(.spotitfiyWhite))")
        }
    }
    
    private var buttonsRow: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "plus.circle")
                    .padding(8)
                    .background(.spotitfiyBlack.opacity(0.001))
                    .onTapGesture {
                        onAddToPlaylistPressed?()
                    }
                
                Image(systemName: "arrow.down.circle")
                    .padding(8)
                    .background(.spotitfiyBlack.opacity(0.001))
                    .onTapGesture {
                        onDownloadPressed?()
                    }
                
                Image(systemName: "square.and.arrow.up")
                    .padding(8)
                    .background(.spotitfiyBlack.opacity(0.001))
                    .onTapGesture {
                        onSharePressed?()
                    }
                
                Image(systemName: "ellipsis")
                    .padding(8)
                    .background(.spotitfiyBlack.opacity(0.001))
                    .onTapGesture {
                        onEllipsisPressed?()
                    }
            }
            .offset(x: -8)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 8) {
                Image(systemName: "shuffle")
                    .font(.system(size: 24))
                    .background(.spotitfiyBlack.opacity(0.001))
                    .onTapGesture {
                        onShufflePressed?()
                    }
                
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 46))
                    .background(.spotitfiyBlack.opacity(0.001))
                    .onTapGesture {
                        onPlayPressed?()
                    }
            }
            .foregroundStyle(.spotitfiyGreen)
        }
        .font(.title2)
    }
}

#Preview {
    ZStack {
        Color.spotitfiyBlack.ignoresSafeArea()
        PlaylistDesriptionCell()
            .padding()
    }
}
