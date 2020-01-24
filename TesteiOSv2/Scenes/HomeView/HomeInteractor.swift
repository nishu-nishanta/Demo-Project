//
//  HomeInteractor.swift
//  TesteiOSv2
//
//  Created by Nishu Nishanta on 21/12/19.
//  Copyright (c) 2019 Nishu Nishanta. All rights reserved.
//

import UIKit

protocol HomeBusinessLogic
{
    func fetchRegisters(request: Home.FetchRegisters.Request)
    func getFetchRegisters(request: Home.FetchRegisters.Request)
    func getUserInfo(request: Home.GetUserInfo.Request)
}

protocol HomeDataStore
{
    var userInfo: UserInfo! { get set }
    var listRegister: [Register]! {get set}
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore
{    
    var listRegister: [Register]!
    var userInfo: UserInfo!
    
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
    var dataStore: HomeDataStore?
    
    func getUserInfo(request: Home.GetUserInfo.Request) {
        let response = Home.GetUserInfo.Response(userInfo: userInfo)
        presenter?.presentUserInfo(response: response)
    }

    func getFetchRegisters(request: Home.FetchRegisters.Request) {
        let response = Home.FetchRegisters.Response.init(success: true, registers: listRegister)
        presenter?.presentRegisters(response: response)
    }

    func fetchRegisters(request: Home.FetchRegisters.Request)
    {
        worker = HomeWorker()
        worker?.doRegistersRequest(userid: request.userId) { (success, registerList) in
            let response = Home.FetchRegisters.Response(success: success, registers: registerList!)
            self.presenter?.presentRegisters(response: response)
        }
    }
}
