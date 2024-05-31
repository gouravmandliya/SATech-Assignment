//
//  NetworkErrorManager.swift
//  SATech-Assignment
//
//  Created by Gourav on 29/05/24.
//

import Foundation

struct ErrorManager {
    static func handleError(_ error: APIError) -> String {
        switch error {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError(let decodingError):
            return "Failed to decode response: \(decodingError)"
        case .invalidResponse:
            return "Invalid response from server"
        case .httpError(let statusCode):
            return "HTTP Error: \(statusCode)"
        case .serverError(let errorMessage):
             return errorMessage
        case .networkError(let networkError):
             return "Network error: \(networkError.localizedDescription)"
        }
    }
}
