//
//  HistoricalSiteListViewModel.swift
//  History-Project-ios
//
//  Created by daeun on 29/05/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class HistoricalSiteListViewModel: ViewModelType {
    
    let api = MainApi()
    
    struct Input {
        let area: Driver<String>
        let selectedIndex: Driver<IndexPath>
    }
    
    struct Output {
        let list: Driver<[HistoricalSiteListModel]>
        let selectedSiteCode: Driver<String>
        let area: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        let list = input.area.asObservable().flatMap { [weak self] area -> Observable<[HistoricalSiteListModel]> in
            guard let strongSelf = self else {return Observable.of([])}
            return strongSelf.api.getHistoricalSiteList(area: area)
        }.asDriver(onErrorJustReturn: [])
        
        let selectedSiteCode = Observable.combineLatest(input.selectedIndex.asObservable(), list.asObservable(), resultSelector: { (index, data) in
            
            return data[index.row].code
        }).asDriver(onErrorJustReturn: "")
        
        let area = input.area.asObservable().map { area -> String in
            switch area {
            case "bla": return "블라디보스톡"
            case "usu": return "우수리스크"
            default: return "오류"
            }
        }.asDriver(onErrorJustReturn: "")
        
        return Output(list: list, selectedSiteCode: selectedSiteCode, area: area)
    }
}
