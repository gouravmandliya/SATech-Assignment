//
//  LoginViewModel.swift
//  SATech-Assignment
//
//  Created by Gourav on 28/05/24.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
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

    func login(completion: @escaping (Bool) -> Void) {
        guard validateFields() else {
            self.errorMessage = "Please fill in all fields correctly."
            completion(false)
            return
        }
        authService.login(email: email, password: password) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
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

extension LoginViewModel {
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
