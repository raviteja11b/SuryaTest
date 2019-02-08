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

final class NetworkLayer{
    public static let shared = NetworkLayer()
}

extension NetworkLayer{
    func getListOfUsers(withUserEmail emailId : String) -> RxSwift.Observable<(HTTPURLResponse, Any)>{
        let parameters = ["emailId" : emailId]
        return RxAlamofire.requestJSON(.post, NetworkKeys.baseUrl + NetworkKeys.Users.list, parameters: parameters, encoding: JSONEncoding.default)
    }
}
