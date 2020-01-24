//
//  HomeInteractorTests.swift
//  TesteiOSv2
//
//  Created by Nishu Nishanta on 13/1/20.
//  Copyright (c) 2020 Nishu Nishanta. All rights reserved.
//

@testable import TesteiOSv2
import XCTest

class HomeInteractorTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: HomeInteractor!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupHomeInteractor()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupHomeInteractor()
  {
    sut = HomeInteractor()
  }
  
  // MARK: Test doubles
  
  class HomePresentationLogicSpy: HomePresentationLogic
  {
    var presentRegisterCalled = false

    func presentRegisters(response: Home.FetchRegisters.Response) {
        presentRegisterCalled = true
    }
    
    func presentUserInfo(response: Home.GetUserInfo.Response) {
    }
  }
  
  // MARK: Tests
  
  func testFetchRegisters()
  {
    // Given
    let spy = HomePresentationLogicSpy()
    sut.presenter = spy
    let request = Home.FetchRegisters.Request(userId: "1")
    sut.listRegister = [Register(title: "Pagamento", desc: "Conta de luz", date: "2018-10-20", value: 100.0)]
    // When
    sut.getFetchRegisters(request: request)
    
    // Then
    XCTAssertTrue(spy.presentRegisterCalled, "getFetchRegisters(request:) should ask the presenter to format the result")
  }
}
