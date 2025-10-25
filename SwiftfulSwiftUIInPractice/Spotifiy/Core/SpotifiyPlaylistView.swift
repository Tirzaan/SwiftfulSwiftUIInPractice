//
//  SpotifiyPlaylistView.swift
//  SwiftfulSwiftUIInPractice
//
//  Created by Tirzaan on 10/23/25.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifiyPlaylistView: View {
    @Environment(\.router) var router

    var product: Product = .mock
    var currentUser: User = .mock
    
    @State private var products: [Product] = []
    @State private var showHeader: Bool = false
    
    var body: some View {
        ZStack {
            Color.spotitfiyBlack.ignoresSafeArea()
            
            ScrollView {
                LazyVStack(spacing: 12) {
                    PlaylistHeaderCell(
                        height: 250,
                        title: product.title,
                        subtitle: product.brand ?? "",
                        imageName: product.firstImage
                    )
                    .readingFrame { frame in
                        showHeader = frame.maxY < 150
                    }
                    
                    PlaylistDesriptionCell(
                        discriptionText: product.description,
                        userName: currentUser.firstName,
                        subheadline: product.category.rawValue.capitalized
                    )
                    .padding(.horizontal, 16)
                    
                    ForEach(products) { product in
                        SongRowCell(
                            imageSize: 50,
                            imageName: product.firstImage,
                            title: product.title,
                            subtitle: product.brand,
                            onCellPressed: {
                                goToPlaylistView(product: product)
                            }
                        )
                        .padding(.leading, 16)
                    }
                    
                }
            }
            .scrollIndicators(.hidden)
            
            header
        }
        .task {
            await getData()
        }
    }
    
    private func getData() async {
        guard products.isEmpty else { return }
        do {
            products = try await DatabaseHelper().getProducts()
        } catch {
            
        }
    }
    
    private var header: some View {
        ZStack {
            Text(product.title)
                .font(.headline)
                .foregroundStyle(.spotitfiyWhite)
                .padding(.bottom, 20)
                .frame(maxWidth: .infinity)
                .background(.spotitfiyBlack)
                .offset(y: showHeader ? 0 : -40)
                .opacity(showHeader ? 1 : 0)
            
//                Image(systemName: "chevron.left")
//                    .font(.headline)
//                    .padding(10)
//                    .glassEffect()
//                    .clipShape(Circle())
//                    .onTapGesture {
//
//                    }
//                    .padding(.leading, 16)
//                    .frame(maxWidth: .infinity, alignment: .leading)
        }
        .animation(.smooth(duration: 0.2), value: showHeader)
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    private func goToPlaylistView(product: Product) {
        router.showScreen(.push) { _ in
            SpotifiyPlaylistView(product: product, currentUser: currentUser)
        }
    }
}

#Preview {
    RouterView { _ in
        SpotifiyPlaylistView()
    }
}
