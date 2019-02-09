//
//  SRUserTableViewCell.swift
//  Surya
//
//  Created by RaviTeja on 09/02/19.
//  Copyright © 2019 RaviTeja. All rights reserved.
//

import UIKit

class SRUserTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailIdLabel: UILabel!
    func setupCell(forUser user : SRUser){
//        userImage?.image
        userNameLabel?.text = "\(user.firstName) \(user.lastName)"
        userEmailIdLabel?.text = user.emailId
    }

}
