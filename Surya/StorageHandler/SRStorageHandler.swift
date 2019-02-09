//
//  SRStorageHandler.swift
//  Surya
//
//  Created by RaviTeja on 09/02/19.
//  Copyright © 2019 RaviTeja. All rights reserved.
//

import Foundation
class SRStorageHandler {
    static let shared = SRStorageHandler.init()
    private let defaults = UserDefaults.standard
    
    func saveData(data : Data?, forKey: String){
        defaults.set(data, forKey: forKey)
    }
    func getData(forKey: String)->Data?{
        return defaults.data(forKey: forKey)
    }
}

extension SRStorageHandler{
    struct StorageKeys{
        static let usersList = "ListOfUsers"
        static let userEmailId = "EnteredEmailId"
    }
}
