//
//  LoginInteractor.swift
//  TesteiOSv2
//
//  Created by Nishu Nishanta on 21/12/19.
//  Copyright (c) 2019 Nishu Nishanta. All rights reserved.
//

import UIKit

protocol LoginBusinessLogic
{
  func doLogin(request: Login.LoginFormFields.Request)
}

protocol LoginDataStore
{
  var userInfo: UserInfo { get set }
}

class LoginInteractor: LoginBusinessLogic, LoginDataStore
{
    var userInfo = UserInfo()
    
    var presenter: LoginPresentationLogic?
    var router: LoginRouter?
    var worker = LoginWorker()
    var isLoggedIn = false

  // MARK: Do login method for protocol login business logic
  
    func doLogin(request: Login.LoginFormFields.Request)
    {
        worker = LoginWorker()
        print("doLogin: user:\(request.user) pwd:\(request.password)")
        worker.doLoginRequest(user: request.user, password: request.password) { (success, userInfo) in
            self.isLoggedIn = success
            let response = Login.LoginFormFields.Response(success: success, info: userInfo!)
            self.userInfo = userInfo!
            self.presenter?.presentLogin(response: response)
        }
    }
    
    func getLogin(request: Login.LoginFormFields.Request) {
        let response = Login.LoginFormFields.Response(success: true, info: self.userInfo)
        self.presenter?.presentLogin(response: response)
    }
}
