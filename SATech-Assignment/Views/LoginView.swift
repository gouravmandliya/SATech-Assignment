//
//  LoginView.swift
//  SATech-Assignment
//
//  Created by Gourav on 28/05/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel(authService: AuthService())
    @State var displaySignupView: Bool = false
    @State var displayInspectionView: Bool = false

    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack {
                    TextField("Email", text: $viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                    
                    NavigationLink(destination:
                                   
                        InspectionView(viewModel: InspectionViewModel(inspectionService: InspectionService())), isActive: $displayInspectionView) {
                        Button("Login") {
                            
                            viewModel.login { success in
                                displayInspectionView.toggle()

                            }
                        }
                    }
                   
                    .padding(.vertical, 20)
                    .disabled(!viewModel.isValid)
                    
                    Spacer()
                    
                    Button("Signup") {
                        displaySignupView.toggle()
                    }
                    .sheet(isPresented: $displaySignupView) {
                        SignupView()
                    }
                }
                .padding()
            }
            .navigationTitle("Login")
        }
        .navigationViewStyle(.stack)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

