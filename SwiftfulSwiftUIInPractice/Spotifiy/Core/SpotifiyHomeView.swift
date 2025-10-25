//
//  SpotifiyHomeView.swift
//  SwiftfulSwiftUIInPractice
//
//  Created by Tirzaan on 10/22/25.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifiyHomeView: View {
    @Environment(\.router) var router

    @State private var currentUser: User? = nil
    @State private var selectedCategory: SpotifiyCategory = SpotifiyCategory.all
    @State private var products: [Product] = []
    @State private var productRows: [ProductRow] = []
    
    var body: some View {
        ZStack {
            Color.spotitfiyBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 1, pinnedViews: .sectionHeaders) {
                    Section {
                        VStack(spacing: 16) {
                            recents
                                .padding(.horizontal, 16)
                            
                            if let product = products.first {
                                newRelease(product: product)
                                    .padding(.horizontal, 16)
                            }
                            
                            listRows
                        }
                    } header: {
                        header
                    }
                }
                .padding(.top, 8)
            }
            .scrollIndicators(.hidden)
            .clipped()
        }
        .task {
            await getData()
        }
    }
    
    // MARK: SUBVIEWS
    private var header: some View {
        HStack(spacing: 0) {
            ZStack {
                if let currentUser {
                    ImageLoaderView(urlString: currentUser.image)
                        .background(.spotitfiyWhite)
                        .clipShape(Circle())
                        .onTapGesture {
                            router.dismissScreen()
                        }
                }
            }
            .frame(width: 30, height: 30)
            
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(SpotifiyCategory.allCases, id: \.self) { category in
                        SpotifiyCategoryCell(
                            title: category.rawValue.capitalized,
                            isSelected: category == selectedCategory)
                        .onTapGesture {
                            selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.vertical, 24)
        .padding(.leading, 8)
        .background(Color.spotitfiyBlack)
    }
    
    private var recents: some View {
        NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: products) { product in
            if let product {
                SpotifiyRecentsCell(
                    imageName: product.firstImage,
                    title: product.title
                )
                .asButton(.press) {
                    goToPlaylistView(product: product)
                }
            }
        }
    }
    
    private func newRelease(product: Product) -> some View {
        SpotifiyNewReleaseCell(
            imageName: product.firstImage,
            headline: product.brand,
            subheadline: product.category.rawValue,
            title: product.title,
            subTitle: product.description,
            onAddToPlaylistPressed: nil,
            onPlayPressed: {
                goToPlaylistView(product: product)
            }
        )
    }
    
    private var listRows: some View {
        ForEach(productRows) { row in
            VStack(spacing: 8) {
                Text(row.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.spotitfiyWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(row.products) { product in
                            ImageTitleRowCell(
                                imageName: product.firstImage,
                                title: product.title,
                                imageSize: 120
                            )
                            .asButton(.press) {
                                goToPlaylistView(product: product)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
    
    // MARK: FUNCTIONS
    private func goToPlaylistView(product: Product) {
        guard let currentUser else { return }
        router.showScreen(.push) { _ in
            SpotifiyPlaylistView(product: product, currentUser: currentUser)
        }
    }
    
    private func getData() async {
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            let allProducts = try await DatabaseHelper().getProducts()
            products = try await Array(DatabaseHelper().getProducts().prefix(8))
//            let lastProducts = try await Array(DatabaseHelper().getProducts().suffix(8))
            
            var rows: [ProductRow] = []
            let allCategories = Set(allProducts.map({ $0.category.rawValue }))
            for category in allCategories {
                let brandProducts = allProducts.filter({ $0.category.rawValue == category })
                rows.append(ProductRow(title: category.capitalized, products: brandProducts))
            }
            productRows = rows
        } catch {
            
        }
    }
}

#Preview {
    RouterView { _ in
        SpotifiyHomeView()
    }
}
