//
//  RegisterCell.swift
//  TesteiOSv2
//
//  Created by Nishu Nishanta on 21/12/19.
//  Copyright (c) 2019 Nishu Nishanta. All rights reserved.
//

import UIKit



class RegisterCell: UITableViewCell
{
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var value: UILabel!

    var displayedRegister: Home.DisplayedRegister?
    {
        didSet
        {
            title.text = displayedRegister?.title
            desc.text = displayedRegister?.desc
            date.text = displayedRegister?.date
            value.text = displayedRegister?.value
        }
    }
}

