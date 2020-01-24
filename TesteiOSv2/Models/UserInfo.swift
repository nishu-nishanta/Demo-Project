//
//  UserInfo.swift
//  TesteiOSv2
//
//  Created by Nishu Nishanta on 21/12/19.
//  Copyright (c) 2019 Nishu Nishanta. All rights reserved.
//

import Foundation

struct UserInfo: Equatable
{
    var userId  : String?
    var name    : String?
    var bankAccount : String?
    var agency : String?
    var balance : Float32?

    static func ==(lhs: UserInfo, rhs: UserInfo) -> Bool
    {
        return lhs.userId == rhs.userId
            && lhs.name == rhs.name
            && lhs.bankAccount == rhs.bankAccount
            && lhs.agency == rhs.agency
            && lhs.balance == rhs.balance
    }
}
