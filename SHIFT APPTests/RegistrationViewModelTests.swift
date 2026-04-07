//
//  RegistrationViewModelTests.swift
//  SHIFT APP
//
//  Created by Вероника Москалюк on 07.04.2026.
//

import XCTest
import Combine
@testable import SHIFT_APP

final class RegistrationViewModelTests: XCTestCase {
    
    var viewModel: RegistrationViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = RegistrationViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testRegisterButtonEnabledWhenFormValid() {
        viewModel.firstName = "Иван"
        viewModel.lastName = "Петров"
        viewModel.password = "Password123"
        viewModel.confirmPassword = "Password123"
        
        viewModel.updateButtonState()
        
        XCTAssertTrue(viewModel.isRegisterButtonEnabled)
    }
    
    func testRegisterButtonDisabledWhenFirstNameInvalid() {
        viewModel.firstName = "И"
        viewModel.lastName = "Петров"
        viewModel.password = "Password123"
        viewModel.confirmPassword = "Password123"
        
        viewModel.updateButtonState()
        
        XCTAssertFalse(viewModel.isRegisterButtonEnabled)
    }
    
    func testRegisterButtonDisabledWhenLastNameInvalid() {
        viewModel.firstName = "Иван"
        viewModel.lastName = "П"
        viewModel.password = "Password123"
        viewModel.confirmPassword = "Password123"
        
        viewModel.updateButtonState()
        
        XCTAssertFalse(viewModel.isRegisterButtonEnabled)
    }
    
    func testRegisterButtonDisabledWhenPasswordInvalid() {
        viewModel.firstName = "Иван"
        viewModel.lastName = "Петров"
        viewModel.password = "weak"
        viewModel.confirmPassword = "weak"
        
        viewModel.updateButtonState()
        
        XCTAssertFalse(viewModel.isRegisterButtonEnabled)
    }
    
    func testRegisterButtonDisabledWhenPasswordsDoNotMatch() {
        viewModel.firstName = "Иван"
        viewModel.lastName = "Петров"
        viewModel.password = "Password123"
        viewModel.confirmPassword = "Password456"
        
        viewModel.updateButtonState()
        
        XCTAssertFalse(viewModel.isRegisterButtonEnabled)
    }
    
    // MARK: - Register Method Tests
    
    func testRegisterWithValidData() {
        viewModel.firstName = "Иван"
        viewModel.lastName = "Петров"
        let calendar = Calendar.current
        viewModel.birthDate = calendar.date(byAdding: .year, value: -25, to: Date())!
        viewModel.password = "Password123"
        viewModel.confirmPassword = "Password123"
        
        viewModel.register()
        
        XCTAssertFalse(viewModel.showAlert)
    }
    
    func testRegisterWithUnderAgeShowsAlert() {
        viewModel.firstName = "Иван"
        viewModel.lastName = "Петров"
        let calendar = Calendar.current
        viewModel.birthDate = calendar.date(byAdding: .year, value: -16, to: Date())!
        viewModel.password = "Password123"
        viewModel.confirmPassword = "Password123"
        
        viewModel.register()
        
        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, "Вам должно быть 18 лет или больше")
    }
    
    // MARK: - Real-time Validation Tests
    
    func testFirstNameErrorAppearsForShortName() {
        let expectation = XCTestExpectation(description: "Wait for validation")
        
        viewModel.firstName = "И"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            XCTAssertFalse(self.viewModel.firstNameError.isEmpty)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFirstNameErrorClearsForValidName() {
        let expectation = XCTestExpectation(description: "Wait for validation")
        
        viewModel.firstName = "И"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.viewModel.firstName = "Иван"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                XCTAssertTrue(self.viewModel.firstNameError.isEmpty)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testPasswordErrorAppearsForInvalidPassword() {
        let expectation = XCTestExpectation(description: "Wait for validation")
        
        viewModel.password = "weak"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            XCTAssertFalse(self.viewModel.passwordError.isEmpty)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
