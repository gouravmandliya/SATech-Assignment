//
//  Extension+Encodable.swift
//  SATech-Assignment
//
//  Created by Gourav on 29/05/24.
//

import Foundation

extension Encodable {
    func toDictionary() -> [String: Any]? {
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(self)
            if let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                return dictionary
            } else {
                print("Failed to convert JSON data to dictionary")
                return nil
            }
        } catch {
            print("Error encoding object to JSON: \(error)")
            return nil
        }
    }
}
