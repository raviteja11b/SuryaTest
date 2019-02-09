//
//  HomeViewModel.swift
//  Surya
//
//  Created by RaviTeja on 08/02/19.
//  Copyright © 2019 RaviTeja. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
class SRUsersViewModel {
    private var model = SRUserDataModel.init()
    var isLoading : BehaviorRelay<Bool> {return model.isLoading}
    var usersList :  BehaviorRelay<[SRUser]> {return model.users}
    var userEmailExists : Bool { return model.isUserEmailExists }
    func requestForData(forEmail email: String){
        model.fetchUsersList(forEmail: email)
    }
    func requestForData(){
        if let data = SRStorageHandler.shared.getData(forKey: SRStorageHandler.StorageKeys.userEmailId){
            requestForData(forEmail: String.init(data: data, encoding: .utf8) ?? "")
        }
    }
    
}
