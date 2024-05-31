//
//  InspectionViewModel.swift
//  SATech-Assignment
//
//  Created by Gourav on 29/05/24.
//

import Foundation
import SwiftUI

class InspectionViewModel: ObservableObject {
    @Published var inspectionResponse: InspectionResponse?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
      
    private let inspectionService: InspectionServiceProtocol
      
    init(inspectionService: InspectionServiceProtocol) {
          self.inspectionService = inspectionService
    }
    
    func submitInspection(completion: @escaping (Bool) -> Void) {
        guard let inspection = inspectionResponse else {
            return
        }
        inspectionService.submitInspection(inspection: inspection.inspection) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let inspection):
                    self.inspectionResponse = inspection as? InspectionResponse
                    completion(true)
                case .failure(let error):
                    print(error)
                   // self.errorMessage = ErrorManager.handleError(error)
                    completion(false)
                }
            }
        }
    }
    
    func fetchInspection() {
        isLoading = true
        errorMessage = nil
        inspectionService.fetchInspection { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let inspection):
                    self.inspectionResponse = inspection as? InspectionResponse
                case .failure(let error):
                    self.errorMessage = ErrorManager.handleError(error)
                }
            }
        }
    }
    
    var totalScore: Double {
        guard let inspection = inspectionResponse else { return 0.0 }
        
        var score = 0.0
        for category in inspection.inspection.survey.categories {
            for question in category.questions {
                if let selectedId = question.selectedAnswerChoiceId,
                   let choice = question.answerChoices.first(where: { $0.id == selectedId }) {
                    score += choice.score
                }
            }
        }
        return score
    }
    
    var allQuestionsAnswered: Bool {
        guard let inspection = inspectionResponse else { return false }
        
        for category in inspection.inspection.survey.categories {
            for question in category.questions {
                if question.selectedAnswerChoiceId == nil {
                    return false
                }
            }
        }
        return true
    }
}
