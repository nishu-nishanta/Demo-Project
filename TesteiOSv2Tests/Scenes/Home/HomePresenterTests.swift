//
//  HomePresenterTests.swift
//  TesteiOSv2
//
//  Created by Nishu Nishanta on 13/1/20.
//  Copyright (c) 2020 Nishu Nishanta. All rights reserved.
//

@testable import TesteiOSv2
import XCTest

class HomePresenterTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: HomePresenter!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupHomePresenter()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupHomePresenter()
  {
    sut = HomePresenter()
  }
  
  // MARK: Test doubles
  
  class HomeDisplayLogicSpy: HomeDisplayLogic
  {
    var displayHomeCalled = false

    func displayUserInfo(viewModel: Home.GetUserInfo.ViewModel) {
    }
    
    func displayHomeData(viewModel: Home.FetchRegisters.ViewModel) {
        displayHomeCalled = true
    }
  }
  
  // MARK: Tests
  
  func testPresentHome()
  {
    // Given
    let spy = HomeDisplayLogicSpy()
    sut.viewController = spy
    let listRegister = [Register]()
    let response = Home.FetchRegisters.Response(success: true, registers: listRegister)
    
    // When
    sut.presentRegisters(response: response)
    
    // Then
    XCTAssertTrue(spy.displayHomeCalled, "presentSomething(response:) should ask the view controller to display the result")
  }
}
