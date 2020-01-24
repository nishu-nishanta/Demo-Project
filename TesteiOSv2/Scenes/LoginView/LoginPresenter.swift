//
//  LoginPresenter.swift
//  TesteiOSv2
//
//  Created by Nishu Nishanta on 21/12/19.
//  Copyright (c) 2019 Nishu Nishanta. All rights reserved.
//

import UIKit

protocol LoginPresentationLogic
{
  func presentLogin(response: Login.LoginFormFields.Response)
}

class LoginPresenter: LoginPresentationLogic
{
  weak var viewController: LoginDisplayLogic?
  
  // MARK: Method called afetr successful login from api
  
  func presentLogin(response: Login.LoginFormFields.Response)
  {
    let greeting = response.success ? "Hello \(response.info.name ?? "")" : "\(response.info.name ?? "")"
    let viewModel = Login.LoginFormFields.ViewModel(success: response.success, greeting: greeting)
    viewController?.displayLogin(viewModel: viewModel)
  }
}
