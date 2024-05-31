//
//  InspectionView.swift
//  SATech-Assignment
//
//  Created by Gourav on 29/05/24.
//

import SwiftUI

import SwiftUI

struct InspectionView: View {
    @ObservedObject var viewModel: InspectionViewModel
    @State private var showTotalScore = false
  
    var body: some View {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else if let inspection = viewModel.inspectionResponse {
                    List {
                        ForEach(inspection.inspection.survey.categories) { category in
                            Section(header: Text(category.name)) {
                                ForEach(category.questions) { question in
                                    QuestionView(question: question, viewModel: viewModel)
                                }
                            }
                        }
                    }
                    .navigationTitle("Inspection: \(inspection.inspection.area.name)")
                    .navigationBarItems(trailing: Button(action: {
                        viewModel.submitInspection { success in
                            if success {
                             
                            }
                            // temporot
                            showTotalScore = true
                        }
                       
                        
                    }) {
                        Text("Submit")
                    }
                    .disabled(!viewModel.allQuestionsAnswered))
                    .sheet(isPresented: $showTotalScore) {
                        TotalScoreView(viewModel: viewModel)
                    }
                }
            }
            .onAppear {
                viewModel.fetchInspection()
            }
        }
}

struct RadioButton: View {
    var selected: Bool
    var body: some View {
        Circle()
            .stroke(selected ? Color.blue : Color.gray, lineWidth: 2)
            .background(selected ? Circle().fill(Color.blue) : Circle().fill(Color.clear))
            .frame(width: 20, height: 20)
    }
}
