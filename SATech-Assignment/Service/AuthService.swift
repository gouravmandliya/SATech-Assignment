//
//  AuthServiceProtocol.swift
//  SATech-Assignment
//
//  Created by Gourav on 28/05/24.
//

import Foundation

protocol AuthServiceProtocol {
    func login(email: String, password: String, completion: @escaping (APIResponse<User?>) -> Void)
    func signup(email: String, password: String, completion: @escaping (APIResponse<User?>) -> Void)
}


class AuthService: AuthServiceProtocol {
   
    func login(email: String, password: String, completion: @escaping (APIResponse<User?>) -> Void) {
        let params = ["email": email, "password": password]
        NetworkManager.request(endpoint: .login, method: .POST, parameters: params, completion: completion)
    }

    func signup(email: String, password: String, completion: @escaping (APIResponse<User?>) -> Void) {
        let params = ["email": email, "password": password]
        NetworkManager.request(endpoint: .signup, method: .POST, parameters: params, completion: completion)
    }
}
