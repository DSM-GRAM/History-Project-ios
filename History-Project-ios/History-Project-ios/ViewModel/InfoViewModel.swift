//
//  InfoViewModel.swift
//  History-Project-ios
//
//  Created by baby1234 on 26/05/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class InfoViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    
    struct Input {
        let area: BehaviorRelay<String>
        let historicalSiteCode: BehaviorRelay<String>
        let clickNext: Signal<Void>
        let clickHome: Signal<Void>
    }
    
    struct Output {
        let explain: Driver<String>
        let extra: Driver<Extra>
        let extraText: Driver<String>
        let imagePath: Driver<String>
        let location: Driver<String>
        let text: Driver<String>
        
    }
    
    func transform(input: Input) -> Output {
        let explain = BehaviorRelay<String>(value: "")
        let extra = BehaviorRelay<String>(value: "")
        let extraText = BehaviorRelay<String>(value: "")
        let imagePath = BehaviorRelay<String>(value: "")
        let location = BehaviorRelay<String>(value: "")
        let text = BehaviorRelay<String>(value: "")
        
        
        
        let areaAndCode = BehaviorRelay.combineLatest(input.area, input.historicalSiteCode) {($0,$1)}
        
        areaAndCode.asObservable().subscribe { areaAndCode in
            if let areaAndCode = areaAndCode.element {
                let (area, code) = areaAndCode
                
            }
        }
        
        
        
       return
    }
}

class Extra {
    let extraImagePath: String
    let extraLocation: String
    let extraName: String
    
    init(extraImagePath: String, extraLocation: String, extraName: String) {
        self.extraImagePath = extraImagePath
        self.extraLocation = extraLocation
        self.extraName = extraName
    }
}
