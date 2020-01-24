//
//  LoginRouter.swift
//  TesteiOSv2
//
//  Created by Nishu Nishanta on 21/12/19.
//  Copyright (c) 2019 Nishu Nishanta. All rights reserved.
//

import UIKit

@objc protocol LoginRoutingLogic
{
  func routeToShowUserData(segue: UIStoryboardSegue?)
}

protocol LoginDataPassing
{
  var dataStore: LoginDataStore? { get }
}

class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing
{
  weak var viewController: LoginViewController?
  var dataStore: LoginDataStore?
  
  // MARK: Routing
  
  func routeToShowUserData(segue: UIStoryboardSegue?)
  {
    if let segue = segue {
      let destinationVC = segue.destination as! HomeViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToShowUserData(source: dataStore!, destination: &destinationDS)
    } else {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let destinationVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
      var destinationDS = destinationVC.router!.dataStore!
        passDataToShowUserData(source: dataStore!, destination: &destinationDS)
      navigateToShowUserData(source: viewController!, destination: destinationVC)
    }
  }

  // MARK: Navigation
  
  func navigateToShowUserData(source: LoginViewController, destination: HomeViewController)
  {
    source.show(destination, sender: nil)
  }
  
  // MARK: Passing data
  
  func passDataToShowUserData(source: LoginDataStore, destination: inout HomeDataStore)
  {
    destination.userInfo = source.userInfo
  }
}
