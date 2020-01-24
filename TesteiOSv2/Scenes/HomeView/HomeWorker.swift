//
//  HomeWorker.swift
//  TesteiOSv2
//
//  Created by Nishu Nishanta on 21/12/19.
//  Copyright (c) 2019 Nishu Nishanta. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class HomeWorker
{
    func doRegistersRequest(userid: String, completionHandler: @escaping (Bool, [Register]?) -> Void)
    {
        Alamofire.request("https://bank-app-test.herokuapp.com/api/statements/\(userid)", method: .get, encoding: URLEncoding.httpBody)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON(completionHandler: { (response) in
                guard response.result.isSuccess,
                    let value = response.result.value else {
                        print("Error while fetching tags: \(String(describing: response.result.error))")
                        completionHandler(false, nil)
                        return
                }
                
                let json = JSON(value)
                var register = Register(title: "", desc: "", date: "", value: 0.0)
                var registerList = [register]
                if json["statementList"].exists() {
                    registerList.removeAll()
                    for ( _, jsonRegister) in json["statementList"] {
                        if jsonRegister["title"].exists() {
                            register.title = jsonRegister["title"].stringValue
                            register.desc = jsonRegister["desc"].stringValue
                            register.date = jsonRegister["date"].stringValue
                            register.value = jsonRegister["value"].floatValue
                            registerList.append(register)
                        }
                    }
                    completionHandler(true, registerList)

                } else {
                    register.title = "Erro"
                    registerList.append(register)
                    completionHandler(false, registerList)
                }
            })
    }
}
