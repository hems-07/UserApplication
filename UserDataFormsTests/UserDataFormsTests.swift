//
//  UserDataFormsTests.swift
//  UserDataFormsTests
//
//  Created by hemanth.p on 20/01/25.
//

import Testing
import XCTest
@testable import UserDataForms

class UsersViewModelTest: XCTestCase{
    var viewModel: UsersViewModel!
    var userModel: UserForms!
    
    override func setUp(){
        super.setUp()
        viewModel = UsersViewModel()
        userModel = UserForms(viewModel: UsersViewModel(), isPresented: .constant(true))
    }
    
    override func tearDown(){
        viewModel = nil
        super.tearDown()
    }
    
    func testAddUser(){
        let initialCount = viewModel.users.count
        
        let newUser = Users(firstName: "FirstName", lastName: "LastName", gender: "Other", email: "example@gmail.com", phone: "9150505050", DOB: Date.now)
        viewModel.users.append(newUser)
        XCTAssertEqual(viewModel.users.count, initialCount+1)
        XCTAssertEqual(viewModel.users[0].firstName, "FirstName")
        XCTAssertEqual(viewModel.users[0].lastName, "LastName")
    }
    
    func testEmailValidation() {
        let validEmail = "test@example.com"
        let invalidEmail = "testexample.com"
        
        XCTAssertTrue(userModel.isValidEmail(validEmail))
        XCTAssertFalse(userModel.isValidEmail(invalidEmail))
    }
    
    func testPhoneValidation() {
        let validPhone = "9150998077"
        let invalidPhone = "12323"
        
        XCTAssertTrue(userModel.isValidPhone(validPhone))
        XCTAssertFalse(userModel.isValidPhone(invalidPhone))
    }
    
}

