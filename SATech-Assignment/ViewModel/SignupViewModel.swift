//
//  SignupViewModel.swift
//  SATech-Assignment
//
//  Created by Gourav on 28/05/24.
//

import Foundation
import Combine

class SignupViewModel: ObservableObject {

    private let authService: AuthServiceProtocol
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    
    @Published var isValid: Bool = false
    private var cancellables = Set<AnyCancellable>()

    init(authService: AuthServiceProtocol) {
        self.authService = authService
        setupValidation()
    }
    
    func signup(completion: @escaping (Bool) -> Void) {
        guard validateFields() else {
            self.errorMessage = "Please fill in all fields correctly."
            completion(false)
            return
        }
        authService.signup(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self.errorMessage = nil // reset
                    completion(true)
                case .failure(let error):
                    self.errorMessage = ErrorManager.handleError(error)
                    completion(false)
                }
            }
        }
    }
}

extension SignupViewModel {
    private func setupValidation() {
        Publishers.CombineLatest($email, $password)
            .map { email, password in
                return email.isValidEmail && password.isValidPassword
            }
            .assign(to: \.isValid, on: self)
            .store(in: &cancellables)
    }

    private func validateFields() -> Bool {
        return email.isValidEmail && password.isValidPassword
    }
}

