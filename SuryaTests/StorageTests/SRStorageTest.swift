//
//  SRStorageTest.swift
//  SuryaTests
//
//  Created by RaviTeja on 09/02/19.
//  Copyright © 2019 RaviTeja. All rights reserved.
//

import XCTest
@testable import Surya

class SRStorageTest: XCTestCase {
    func testStoring() {
        let storageKey = "StorageTestKey"
        let testString = "Test"
        SRStorageHandler.shared.saveData(data: testString.data(using: .utf8), forKey: storageKey)
        if let data = SRStorageHandler.shared.getData(forKey: storageKey){
            let st = String.init(data: data, encoding: .utf8)
            XCTAssert(st == testString , "Storing issue")
        }else{
            XCTFail("Storing issue")
        }
        SRStorageHandler.shared.saveData(data: nil, forKey: storageKey)
    }
}
