//
//  SuryaTests.swift
//  SuryaTests
//
//  Created by RaviTeja on 08/02/19.
//  Copyright © 2019 RaviTeja. All rights reserved.
//

import XCTest
@testable import Surya
import RxSwift
import RxCocoa

class SuryaTests: XCTestCase {

    func testSRUserViewModel() {
        let model = SRUsersViewModel.init()
        let bag = DisposeBag()
        let listExpe = expectation(description: "List of users Response")
        removeOldData()
        model.usersList.asObservable().subscribe(onNext: {[weak self] (users) in
            if users.count > 0{
                XCTAssert(self?.checkDataStorage() ?? false, "Data Not storing locally")
                listExpe.fulfill()
            }
        }).disposed(by: bag)
        model.requestForData(forEmail: "test@test.com")
        wait(for: [listExpe], timeout: 10)
    }
    
    func removeOldData(){
        SRStorageHandler.shared.saveData(data: nil, forKey: SRStorageHandler.StorageKeys.usersList)
    }
    
    func checkDataStorage()->Bool{
        return SRStorageHandler.shared.getData(forKey: SRStorageHandler.StorageKeys.usersList) != nil
    }

}
