//
//  NetworkLayer.swift
//  Surya
//
//  Created by RaviTeja on 08/02/19.
//  Copyright © 2019 RaviTeja. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

class SRNetworkLayer{
    public static let shared = SRNetworkLayer()
}

extension SRNetworkLayer{
    func getListOfUsers(withUserEmail emailId : String) -> RxSwift.Observable<(HTTPURLResponse, Data)>{
        let parameters = ["emailId" : emailId]
        return RxAlamofire.requestData(.post, SRNetworkUtils.baseUrl + SRNetworkUtils.Users.list, parameters: parameters, encoding: JSONEncoding.default)
    }
}
