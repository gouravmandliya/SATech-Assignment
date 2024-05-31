//
//  TotalScoreView.swift
//  SATech-Assignment
//
//  Created by Gourav on 29/05/24.
//

import SwiftUI

struct TotalScoreView: View {
    @ObservedObject var viewModel: InspectionViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text(String(format: "%.2f", viewModel.totalScore))
                    .font(.system(size: 60, weight: .bold, design: .rounded))
                    .foregroundColor(.blue)
                    .padding()
                Spacer()
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Done")
                        .font(.headline)
                        .padding()
                }
            }
            .padding()
            .navigationTitle("Inspection Score")
        }
    }
}
