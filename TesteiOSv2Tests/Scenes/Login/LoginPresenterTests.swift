//
//  LoginPresenterTests.swift
//  TesteiOSv2
//
//  Created by Nishu Nishanta on 13/1/20.
//  Copyright (c) 2020 Nishu Nishanta. All rights reserved.
//

@testable import TesteiOSv2
import XCTest

class LoginPresenterTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: LoginPresenter!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupLoginPresenter()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupLoginPresenter()
  {
    sut = LoginPresenter()
  }
  
  // MARK: Test doubles
  
  class LoginDisplayLogicSpy: LoginDisplayLogic
  {
    
    var displayLoginCalled = false

    var viewModel = Login.LoginFormFields.ViewModel(success: true, greeting: "Login OK")
    
    func displayLogin(viewModel: Login.LoginFormFields.ViewModel) {
        displayLoginCalled = true
        self.viewModel = viewModel
    }
  }
  
  // MARK: Tests
  
  func testPresentLogin()
  {
    // Given
    let spy = LoginDisplayLogicSpy()
    sut.viewController = spy
    let successResult = true
    var userInfo = UserInfo()
    userInfo.name = "Mr Tester"
    let response = Login.LoginFormFields.Response(success: successResult, info: userInfo)
    
    // When
    sut.presentLogin(response: response)
    
    // Then
    
    XCTAssertTrue(spy.displayLoginCalled, "presentSomething(response:) should ask the view controller to display the result")
  }
}
