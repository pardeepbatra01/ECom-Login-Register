//
//  LoginModel.swift
//  Demo
//
//  Created by Sushil Chaudhary on 13/09/24.
//

import Foundation

//MARK: - LOGIN MODEL

// Codable struct for the login response
struct LoginResponse: Codable {
    let user: User
    let token: String
    
    
    init(user: User, token: String) {
        self.user = user
        self.token = token
    }
    
    // Add a custom decoder in case additional handling is needed in the future
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        user = try container.decode(User.self, forKey: .user)
        token = try container.decode(String.self, forKey: .token)
    }
    
    // For debugging, include a description of the data
    var description: String {
        return "User: \(user.name), Token: \(token)"
    }
}

// Codable struct for the user details
struct User: Codable {
    let id: Int
    let name: String
    let email: String
    
    // Custom init in case other values need to be added later
    init(id: Int, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
    }
    
    // Custom decoder for potential future customization
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
    }
    
    // Description for debugging purposes
    var description: String {
        return "ID: \(id), Name: \(name), Email: \(email)"
    }
}
