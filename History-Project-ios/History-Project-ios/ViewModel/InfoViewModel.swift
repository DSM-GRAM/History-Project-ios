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
        let clickHome: Signal<Void>
        let clickNext: Signal<Void>
        let clickList: Signal<Void>
    }
    
    struct Output {
        let explain: Driver<String>
        let extra: Driver<[InfoModel.Extra]>
        let extraText: Driver<String>
        let imagePath: Driver<String>
        let location: Driver<String>
        let text: Driver<String>
        let goVC: BehaviorRelay<GoWhere>
    }
    
    func transform(input: Input) -> Output {
        let explain = BehaviorRelay<String>(value: "")
        let extra = BehaviorRelay<[InfoModel.Extra]>(value: [])
        let extraText = BehaviorRelay<String>(value: "")
        let imagePath = BehaviorRelay<String>(value: "")
        let location = BehaviorRelay<String>(value: "")
        let text = BehaviorRelay<String>(value: "")
        let goVC = BehaviorRelay<GoWhere>(value: .stay)
        
        let areaAndCode = BehaviorRelay.combineLatest(input.area, input.historicalSiteCode) {($0,$1)}
        
        areaAndCode.asObservable().subscribe { [weak self] areaAndCode in
            if let areaAndCode = areaAndCode.element {
                let (area, code) = areaAndCode
                let mainApi = MainApi()
                
                guard let strongSelf = self else{ return }
                
                mainApi.getInfo(area: area, historySiteCode: code).subscribe({ model in
                    if let model = model.element {
                        if let model = model {
                            explain.accept(model.explain ?? "")
                            extra.accept(model.extra ?? [])
                            extraText.accept(model.extraText ?? "")
                            imagePath.accept(model.imagePath ?? "")
                            location.accept(model.location ?? "")
                            text.accept(model.text ?? "")
                        }
                    }
                }).disposed(by: strongSelf.disposeBag)
            }
        }.disposed(by: disposeBag)
        
        input.clickList.asObservable().subscribe({ _ in
            goVC.accept(.goSiteList)
        }).disposed(by: disposeBag)
        
        input.clickHome.asObservable().subscribe({ _ in
            goVC.accept(.home)
        }).disposed(by: disposeBag)
        
        input.clickNext.asObservable().subscribe({ _ in
            goVC.accept(.next)
        }).disposed(by: disposeBag)
        
    
        return Output(explain: explain.asDriver(), extra: extra.asDriver(), extraText: extraText.asDriver(), imagePath: imagePath.asDriver(), location: location.asDriver(), text: text.asDriver(), goVC: goVC)
    }
}

enum GoWhere {
    case home, next, back, goSiteList, stay
}
