//
//  SignupView.swift
//  SATech-Assignment
//
//  Created by Gourav on 28/05/24.
//

import SwiftUI

struct SignupView: View {
    @StateObject var viewModel = SignupViewModel(authService: AuthService())
    @Environment(\.presentationMode) var presentationMode
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
                    
                    Button("Signup") {
                        viewModel.signup { success in
                            if success {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
                    .padding(.vertical, 20)
                    .disabled(!viewModel.isValid)
                }
                .padding()
            }
            .navigationTitle("Register")
        }
        .navigationViewStyle(.stack)
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}


