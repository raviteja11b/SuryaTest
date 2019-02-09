//
//  UsersDataModel.swift
//  Surya
//
//  Created by RaviTeja on 08/02/19.
//  Copyright © 2019 RaviTeja. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SRUserDataModel {
    let bag = DisposeBag()
    var users = BehaviorRelay<[SRUser]>.init(value: [])
    var isLoading = BehaviorRelay<Bool>.init(value: false)
    var isUserEmailExists : Bool{
        return SRStorageHandler.shared.getData(forKey: SRStorageHandler.StorageKeys.userEmailId) != nil
    }
    
    func fetchUsersList(forEmail email : String){
        if isUserEmailExists, let data = SRStorageHandler.shared.getData(forKey: SRStorageHandler.StorageKeys.usersList){
            let usersList : SRListOfUsers? = SRNetworkUtils.parseData(withData: Data(data))
            users.accept(usersList?.items ?? [])
        }
        
        fetchUsersFromServer(forEmail: email)
    }
    
    func fetchUsersFromServer(forEmail email : String){
        isLoading.accept(true)
        SRNetworkLayer.shared.getListOfUsers(withUserEmail: email).asObservable().subscribe(onNext: {[weak self] (response, data) in
            self?.isLoading.accept(false)
            if response.statusCode == 200{
                let list : SRListOfUsers? = SRNetworkUtils.parseData(withData: Data(data))
                SRStorageHandler.shared.saveData(data: email.data(using: .utf8), forKey: SRStorageHandler.StorageKeys.userEmailId)
                SRStorageHandler.shared.saveData(data: data, forKey: SRStorageHandler.StorageKeys.usersList)
                self?.users.accept(list?.items ?? [])
            }else{
                print("error with Status Code \(response.statusCode)")
            }
        }, onError: {[weak self] (error) in
            self?.isLoading.accept(true)
            print(#function, #line)
            print("error \(error.localizedDescription)")
        }).disposed(by: bag)
    }
}
