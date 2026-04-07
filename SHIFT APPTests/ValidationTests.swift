//
//  ValidationTests.swift
//  SHIFT APP
//
//  Created by Вероника Москалюк on 07.04.2026.
//

import XCTest
@testable import SHIFT_APP

final class ValidationTests: XCTestCase {
    
    var validation: ValidationService!
    
    override func setUp() {
        super.setUp()
        validation = ValidationService()
    }
    
    override func tearDown() {
        validation = nil
        super.tearDown()
    }
    
    func testValidName() {
        XCTAssertTrue(validation.isNameValid("Иван"))
        XCTAssertTrue(validation.isNameValid("Анна"))
        XCTAssertTrue(validation.isNameValid("Екатерина"))
    }
    
    func testInvalidNameTooShort() {
        XCTAssertFalse(validation.isNameValid("И"))
        XCTAssertFalse(validation.isNameValid("A"))
    }
    
    func testEmptyName() {
        XCTAssertFalse(validation.isNameValid(""))
        XCTAssertFalse(validation.isNameValid("   "))
    }
    
    func testValidPassword() {
        XCTAssertTrue(validation.isPasswordValid("Password123"))
        XCTAssertTrue(validation.isPasswordValid("Admin2024"))
    }
    
    func testInvalidPasswordNoUppercase() {
        XCTAssertFalse(validation.isPasswordValid("password123"))
        XCTAssertFalse(validation.isPasswordValid("abc123"))
    }
    
    func testInvalidPasswordNoDigit() {
        XCTAssertFalse(validation.isPasswordValid("Password"))
        XCTAssertFalse(validation.isPasswordValid("SecurePass"))
    }
    
    func testInvalidPasswordTooShort() {
        XCTAssertFalse(validation.isPasswordValid("Pas1"))
        XCTAssertFalse(validation.isPasswordValid("Abc1"))
    }
    
    func testEmptyPassword() {
        XCTAssertFalse(validation.isPasswordValid(""))
    }
    
    func testPasswordsMatch() {
        XCTAssertTrue(validation.doPasswordsMatch("pass123", "pass123"))
        XCTAssertTrue(validation.doPasswordsMatch("qwerty456", "qwerty456"))
    }
    
    func testPasswordsDoNotMatch() {
        XCTAssertFalse(validation.doPasswordsMatch("pass123", "pass456"))
        XCTAssertFalse(validation.doPasswordsMatch("qwerty", "qwerty123"))
    }
    
    func testEmptyConfirmPassword() {
        XCTAssertFalse(validation.doPasswordsMatch("pass123", ""))
    }
    
    func testValidAge() {
        let calendar = Calendar.current
        let age18 = calendar.date(byAdding: .year, value: -18, to: Date())!
        let age25 = calendar.date(byAdding: .year, value: -25, to: Date())!
        
        XCTAssertTrue(validation.isAgeValid(birthDate: age18))
        XCTAssertTrue(validation.isAgeValid(birthDate: age25))
    }
    
    func testInvalidAgeUnder18() {
        let calendar = Calendar.current
        let age17 = calendar.date(byAdding: .year, value: -17, to: Date())!
        let age10 = calendar.date(byAdding: .year, value: -10, to: Date())!
        
        XCTAssertFalse(validation.isAgeValid(birthDate: age17))
        XCTAssertFalse(validation.isAgeValid(birthDate: age10))
    }
    
    func testFutureDate() {
        let calendar = Calendar.current
        let futureDate = calendar.date(byAdding: .year, value: 1, to: Date())!
        
        XCTAssertFalse(validation.isAgeValid(birthDate: futureDate))
    }
}
