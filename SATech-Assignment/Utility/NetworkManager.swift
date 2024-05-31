//
//  NetworkManager.swift
//  SATech-Assignment
//
//  Created by Gourav on 28/05/24.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case noData
    case decodingError(Error)
    case invalidResponse
    case httpError(statusCode: Int)
    case serverError(String)
    case networkError(Error)
}

enum APIResponse<T> {
    case success(T?)
    case failure(APIError)
}

struct ErrorResponse: Decodable {
    let error: String
}

enum APIStatusCode: Int {
    case success = 200
    case badRequest = 400
    case unauthorized = 401
}

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum APIEndpoint {
    case login
    case signup
    case inspectionItems
    case submit
    
    var path: String {
        switch self {
        case .login:
            return "login"
        case .signup:
            return "register"
        case .inspectionItems:
            return "inspections/start"
        case .submit:
            return "inspections/submit"
        }
    }
}


final class NetworkManager {
    
    private init() {}
    
    private static let baseURL = "http://127.0.0.1:5001/api/"
    
    static func request<T: Decodable>(endpoint: APIEndpoint, method: HTTPMethod, parameters: [String: Any]? = nil, completion: @escaping (APIResponse<T?>) -> Void) {
        guard let url = URL(string: baseURL + endpoint.path) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let parameters = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
        
           
            guard let statusCode = APIStatusCode(rawValue: httpResponse.statusCode) else {
                completion(.failure(.httpError(statusCode: httpResponse.statusCode)))
                return
            }
            
            switch statusCode {
            case .success:
                // Handle zero byte data as success with nil
                guard let data = data, !data.isEmpty else {
                    completion(.success(nil))
                    return
                }
                
                // for debugging purpose
                if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                    do {
                        if let prettyPrintedData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                            print(String(bytes: prettyPrintedData, encoding: String.Encoding.utf8) ?? "NIL")
                        }
                    }catch {
                        print(error)
                    }
                }
                
                do {
                    let decoder = JSONDecoder()
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    let prettyPrintedData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    let responseObject = try decoder.decode(T.self, from: prettyPrintedData)
                    completion(.success(responseObject))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            case .badRequest, .unauthorized:
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: data)
                    completion(.failure(.serverError(errorResponse.error)))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        task.resume()
    }
}


