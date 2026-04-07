//
//  MainViewModelTests.swift
//  SHIFT APP
//
//  Created by Вероника Москалюк on 07.04.2026.
//

import XCTest
@testable import SHIFT_APP

final class MainViewModelTests: XCTestCase {
    
    var viewModel: MainViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = MainViewModel()
        UserDefaults.standard.removeObject(forKey: "userName")
    }
    
    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: "userName")
        viewModel = nil
        super.tearDown()
    }
    
    func testUserNameWhenSaved() {
        let storage = StorageService()
        storage.saveUserName("ТестовыйПользователь")
        
        XCTAssertEqual(viewModel.userName, "ТестовыйПользователь")
    }
    
    func testUserNameWhenNotSaved() {
        UserDefaults.standard.removeObject(forKey: "userName")
        
        XCTAssertEqual(viewModel.userName, "Гость")
    }
    
    func testLoadProductsSetsLoadingState() {
        viewModel.loadProducts()
        
        XCTAssertTrue(viewModel.isLoading)
    }
    
    func testLoadProductsClearsErrorMessage() {
        viewModel.errorMessage = "Старая ошибка"
        viewModel.loadProducts()
        
        XCTAssertTrue(viewModel.errorMessage.isEmpty)
    }
}
