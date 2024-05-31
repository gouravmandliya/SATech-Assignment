//
//  ServiceMocks.swift
//  SATech-AssignmentTests
//
//  Created by Gourav on 30/05/24.
//

import Foundation

class MockAuthService: AuthServiceProtocol {
    var shouldReturnError = false

    func login(email: String, password: String, completion: @escaping (APIResponse<User?>) -> Void) {
        if shouldReturnError {
            completion(.failure(.invalidResponse))
        } else {
            let user = User(email: "test@example.com", password: "testPassword")
            completion(.success(user))
        }
    }

    func signup(email: String, password: String, completion: @escaping (APIResponse<User?>) -> Void) {
        if shouldReturnError {
            completion(.failure(.invalidResponse))
        } else {
            let user = User(email: "test@example.com", password: "testPassword")
            completion(.success(user))
        }
    }
}
