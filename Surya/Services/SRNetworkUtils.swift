//
//  NetworkUtils.swift
//  Surya
//
//  Created by RaviTeja on 08/02/19.
//  Copyright © 2019 RaviTeja. All rights reserved.
//

import Foundation
struct SRNetworkUtils {
    static let baseUrl = "http://surya-interview.appspot.com"
    struct Users {
        static let list = "/list"
    }
    
    static func parseData< T : Codable >(withData data: Data)->T?{
        let decode = JSONDecoder()
        do{
            let usersList = try decode.decode(T.self, from: data)
            return usersList
        } catch{
            print(error)
        }
        return nil
    }
    
    enum SRResponseState{
        case success
        case failure
        case error
    }
    
    struct SRViewModelResponse{
        var error : Error? = nil
        var errorMessage : String? = nil
        var successMessage : String? = nil
        var statusCode : Int? = nil
        var status : SRResponseState = .failure
        var data : Any? = nil
    }
}

