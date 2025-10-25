//
//  User.swift
//  SwiftfulSwiftUIInPractice
//
//  Created by Tirzaan on 10/22/25.
//

import Foundation

struct UserArray: Codable {
    let users: [User]
    let total, skip, limit: Int
}

struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height, weight: Double
    
    static var mock: User {
        User(
            id: 444,
            firstName: "Tirzaan",
            lastName: "Neil",
            age: 15,
            email: "user@example.com",
            phone: "123-456-8910",
            username: "Tarzan",
            password: "Password",
            image: Constants.randomImage,
            height: 5.9,
            weight: 140
        )
    }
}
