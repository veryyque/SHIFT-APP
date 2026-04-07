//
//  StorageTests.swift
//  SHIFT APP
//
//  Created by Вероника Москалюк on 07.04.2026.
//

import XCTest
@testable import SHIFT_APP

final class StorageTests: XCTestCase {
    
    var storage: StorageService!
    let testName = "ТестовыйПользователь"
    
    override func setUp() {
        super.setUp()
        storage = StorageService()
        UserDefaults.standard.removeObject(forKey: "userName")
    }
    
    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: "userName")
        storage = nil
        super.tearDown()
    }
    
    func testSaveUserName() {
        storage.saveUserName(testName)
        let savedName = UserDefaults.standard.string(forKey: "userName")
        
        XCTAssertEqual(savedName, testName)
    }
    
    func testSaveUserNameOverwrites() {
        let firstName = "Иван"
        let secondName = "Петр"
        
        storage.saveUserName(firstName)
        storage.saveUserName(secondName)
        
        let savedName = UserDefaults.standard.string(forKey: "userName")
        XCTAssertEqual(savedName, secondName)
    }
    
    func testGetUserNameWhenExists() {
        UserDefaults.standard.set(testName, forKey: "userName")
        let result = storage.getUserName()
        
        XCTAssertEqual(result, testName)
    }
    
    func testGetUserNameWhenNotExists() {
        UserDefaults.standard.removeObject(forKey: "userName")
        let result = storage.getUserName()
        
        XCTAssertEqual(result, "Гость")
    }
}
