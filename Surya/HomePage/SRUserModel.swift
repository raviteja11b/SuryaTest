//
//  UserModel.swift
//  Surya
//
//  Created by RaviTeja on 08/02/19.
//  Copyright © 2019 RaviTeja. All rights reserved.
//

import Foundation
struct SRUser : Codable{
    var firstName :  String
    var lastName : String
    var emailId : String
    var imageUrl : String
}

struct SRListOfUsers : Codable{
    var items : [SRUser]
}
