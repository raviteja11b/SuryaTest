//
//  HomeViewModel.swift
//  Surya
//
//  Created by RaviTeja on 08/02/19.
//  Copyright © 2019 RaviTeja. All rights reserved.
//

import Foundation
import RxSwift

class SRHomeViewModel {
    private var model = SRUserDataModel.init()
    var isLoading : Variable<Bool> {return model.isLoading}
    var usersList =  Variable<[SRUser]>.init([])
    
}
