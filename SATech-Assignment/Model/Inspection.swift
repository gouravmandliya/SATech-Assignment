//
//  Inspaction.swift
//  SATech-Assignment
//
//  Created by Gourav on 28/05/24.
//

import Foundation

struct InspectionResponse: Codable {
    var inspection: Inspection
}

struct Inspection: Codable, Identifiable {
    let id: Int
    let area: Area
    let inspectionType: InspectionType
    var survey: Survey
}

struct Area: Codable, Identifiable {
    let id: Int
    let name: String
}

struct InspectionType: Codable, Identifiable {
    let id: Int
    let name: String
    let access: String
}

struct Survey: Codable {
    var categories: [Category]
}

struct Category: Codable, Identifiable {
    let id: Int
    let name: String
    var questions: [Question]
}

struct Question: Codable, Identifiable {
    let id: Int
    let name: String
    let answerChoices: [AnswerChoice]
    var selectedAnswerChoiceId: Int?
}

struct AnswerChoice: Codable, Identifiable {
    let id: Int
    let name: String
    let score: Double
}
