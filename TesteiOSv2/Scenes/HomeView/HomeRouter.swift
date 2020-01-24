//
//  HomeRouter.swift
//  TesteiOSv2
//
//  Created by Nishu Nishanta on 21/12/19.
//  Copyright (c) 2019 Nishu Nishanta. All rights reserved.
//

import UIKit

@objc protocol HomeRoutingLogic
{
}

protocol HomeDataPassing
{
    var dataStore: HomeDataStore? { get set }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing
{
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
}
