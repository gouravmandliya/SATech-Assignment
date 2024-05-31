//
//  LoginViewModelTests.swift
//  SATech-AssignmentTests
//
//  Created by Gourav on 30/05/24.
//

import XCTest
@testable import SATech_Assignment

class LoginViewModelTests: XCTestCase {
    
    var viewModel: LoginViewModel!
    var mockAuthService: MockAuthService!
      
      override func setUp() {
          super.setUp()
          mockAuthService = MockAuthService()
          viewModel = LoginViewModel(authService: mockAuthService)
      }
      
      override func tearDown() {
          viewModel = nil
          mockAuthService = nil
          super.tearDown()
      }
      
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testLoginSuccess() {
        mockAuthService.shouldReturnError = false
        let expectation = self.expectation(description: "Login Success")
        viewModel.email = "test@example.com"
        viewModel.password = "testPassword"
        viewModel.login { success in
            XCTAssertTrue(success)
            XCTAssertNil(self.viewModel.errorMessage)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLoginFailure() {
        mockAuthService.shouldReturnError = true
        let expectation = self.expectation(description: "Login Failure")
        
        viewModel.email = "test@example.com"
        viewModel.password = "testPassword"
        viewModel.login { success in
            XCTAssertFalse(success)
            XCTAssertEqual(self.viewModel.errorMessage, "Invalid response from server")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
