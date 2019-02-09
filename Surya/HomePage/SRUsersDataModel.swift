//
//  UsersDataModel.swift
//  Surya
//
//  Created by RaviTeja on 08/02/19.
//  Copyright © 2019 RaviTeja. All rights reserved.
//

import Foundation
import RxSwift

class SRUserDataModel {
    let bag = DisposeBag()
    var users = Variable<[SRUser]>.init([])
    var isLoading = Variable<Bool>.init(false)
    func fetchUsersList(forEmail email : String){
        
    }
    
    func fetchUsersFromServer(forEmail email : String){
        isLoading.value = true
        SRNetworkLayer.shared.getListOfUsers(withUserEmail: email).asObservable().subscribe(onNext: {[weak self] (response, data) in
            self?.isLoading.value = false
            if response.statusCode == 200{
                let list : SRListOfUsers? = SRNetworkUtils.parseData(withData: Data(data))
                self?.users.value = list?.items ?? []
            }else{
                print("error with Status Code \(response.statusCode)")
            }
        }, onError: {[weak self] (error) in
            self?.isLoading.value = true
            print(#function, #line)
            print("error \(error.localizedDescription)")
        }).disposed(by: bag)
    }
}
