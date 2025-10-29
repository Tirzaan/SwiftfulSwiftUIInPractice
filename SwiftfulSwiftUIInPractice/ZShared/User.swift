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
    let university: String
    let company: Company
    
    var AboutMe: String {
        "My name is \(firstName) \(lastName), and I'm \(age) years old. I studied at \(university). I am currently working at \(company.name)."
    }
    var basics: [UserInterest] {
        [
            UserInterest(iconName: "ruler", emoji: nil, text: "\(height)"),
            UserInterest(iconName: "graduationcap", emoji: nil, text: "\(university)"),
            UserInterest(iconName: "wineglass", emoji: nil, text: "Socially"),
            UserInterest(iconName: "moon.stars.fill", emoji: nil, text: "Virgo"),
        ]
    }
    var interests: [UserInterest] {
        [
            UserInterest(iconName: nil, emoji: "👟", text: "Running"),
            UserInterest(iconName: nil, emoji: "🏋", text: "Gym"),
            UserInterest(iconName: nil, emoji: "🎧", text: "Music"),
            UserInterest(iconName: nil, emoji: "🥘", text: "Cooking"),
        ]
    }
    var images: [String] {
        ["https://picsum.photos/500/500", "https://picsum.photos/600/600", "https://picsum.photos/700/700"]
    }

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
            weight: 140.1,
            university: "Called To Learn",
            company: Company(department: "Department", name: "Company Name", title: "Company Title")
        )
    }
}

struct Company: Codable {
    let department, name, title: String
}
