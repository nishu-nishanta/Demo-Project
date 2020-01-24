//
//  HomeModels.swift
//  TesteiOSv2
//
//  Created by Nishu Nishanta on 21/12/19.
//  Copyright (c) 2019 Nishu Nishanta. All rights reserved.
//

import UIKit

struct Register
{
    var title : String
    var desc : String
    var date : String
    var value : Float32
}

enum Home
{
  // MARK: Use cases
    enum GetUserInfo
    {
        struct Request
        {
        }
        struct Response
        {
            var userInfo: UserInfo
        }
        struct ViewModel
        {
            struct DisplayedUserInfo
            {
                var userId  : String?
                var name    : String?
                var bankAccount : String?
                var agency : String?
                var balance : String?
            }
            var displayedUserInfo: DisplayedUserInfo
        }
    }

    
    struct DisplayedRegister
    {
        var title : String
        var desc : String
        var date : String
        var value : String
    }

  enum FetchRegisters
  {
    struct Request
    {
        var userId: String
    }
    struct Response
    {
        var success: Bool
        var registers: [Register]
    }
    struct ViewModel
    {
        var displayedRegisters: [DisplayedRegister]
        var success: Bool
    }
  }
}
