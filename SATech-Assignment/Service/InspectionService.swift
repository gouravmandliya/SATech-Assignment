//
//  InspectionService.swift
//  SATech-Assignment
//
//  Created by Gourav on 29/05/24.
//

import Foundation

protocol InspectionServiceProtocol {
    func fetchInspection(completion: @escaping (APIResponse<InspectionResponse?>) -> Void)
    func submitInspection(inspection: Inspection, completion: @escaping (APIResponse<InspectionResponse?>) -> Void)
}

class InspectionService: InspectionServiceProtocol {
 
    func fetchInspection(completion: @escaping (APIResponse<InspectionResponse?>) -> Void) {
        NetworkManager.request(endpoint: .inspectionItems, method: .GET, completion: completion)
    }
    
    func submitInspection(inspection: Inspection, completion: @escaping (APIResponse<InspectionResponse?>) -> Void) {
        NetworkManager.request(endpoint: .submit, method: .POST, parameters: inspection.toDictionary(), completion: completion)
    }
}
