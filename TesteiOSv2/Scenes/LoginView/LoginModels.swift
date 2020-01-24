//
//  LoginModels.swift
//  TesteiOSv2
//
//  Created by Nishu Nishanta on 21/12/19.
//  Copyright (c) 2019 Nishu Nishanta. All rights reserved.
//

import UIKit

enum Login
{
  // MARK: Use cases
  
  enum LoginFormFields
  {
    struct Request
    {
        var user: String
        var password: String
    }
    struct Response
    {
        var success: Bool
        var info: UserInfo
    }
    struct ViewModel
    {
        var success: Bool
        var greeting: String
    }
  }
}
