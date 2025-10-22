//
//  ContentView.swift
//  SwiftfulSwiftUIInPractice
//
//  Created by Tirzaan on 10/22/25.
//

import SwiftUI

struct ContentView: View {
    @State private var users: [User] = []
    @State private var products: [Product] = []
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Names:")
                    .font(.title)
                    .fontWeight(.bold)
                ForEach(users) { user in
                    Text(user.firstName)
                }
                Text("Products:")
                    .font(.title)
                    .fontWeight(.bold)
                ForEach(products) { product in
                    Text(product.title)
                }
            }
        }
        .padding()
        .task {
            await getData()
        }
    }
    
    private func getData() async {
        do {
            users = try await DatabaseHelper().getUsers()
            products = try await DatabaseHelper().getProducts()
        } catch {
            
        }
    }
}

#Preview {
    ContentView()
}
