//
//  NetworkLayerTest.swift
//  SuryaTests
//
//  Created by RaviTeja on 08/02/19.
//  Copyright © 2019 RaviTeja. All rights reserved.
//

import XCTest
@testable import Surya
import RxSwift

class NetworkLayerTest: XCTestCase {
    func testListOfUsers() {
        let bag = DisposeBag()
        let networkExpectation = expectation(description: "Network Call for List of users")
        SRNetworkLayer.shared.getListOfUsers(withUserEmail: "test@test.com").asObservable().subscribe(onNext: { (response, data) in
            if response.statusCode == 200{
                let list : SRListOfUsers? = SRNetworkUtils.parseData(withData: Data(data))
                XCTAssertNotNil(list, "List Parse error")
            }else{
                XCTFail("List API Failure from Server with Status Code \(response.statusCode)")
            }
            networkExpectation.fulfill()
        }, onError: { error in
            XCTFail("List API Failure with error \(error.localizedDescription)")
            networkExpectation.fulfill()
        }).disposed(by: bag)
        wait(for: [networkExpectation], timeout: 10)
    }
}
