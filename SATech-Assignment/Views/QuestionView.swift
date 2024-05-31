//
//  QuestionView.swift
//  SATech-Assignment
//
//  Created by Gourav on 29/05/24.
//

import SwiftUI

struct QuestionView: View {
    @State var question: Question
    @ObservedObject var viewModel: InspectionViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(question.name)
                .font(.headline)
            ForEach(question.answerChoices) { choice in
                HStack {
                    Text(choice.name)
                    Spacer()
                    RadioButton(selected: question.selectedAnswerChoiceId == choice.id)
                        .onTapGesture {
                            question.selectedAnswerChoiceId = choice.id
                            // Update the question in the view model
                            updateQuestion()
                        }
                }
            }
        }
        .padding()
    }
    
    func updateQuestion() {
        if let inspection = viewModel.inspectionResponse,
           let categoryIndex = inspection.inspection.survey.categories.firstIndex(where: { $0.questions.contains(where: { $0.id == question.id }) }),
           let questionIndex = inspection.inspection.survey.categories[categoryIndex].questions.firstIndex(where: { $0.id == question.id }) {
            viewModel.inspectionResponse?.inspection.survey.categories[categoryIndex].questions[questionIndex] = question
        }
    }
}
