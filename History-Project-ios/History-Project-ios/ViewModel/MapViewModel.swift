//
//  MapViewModel.swift
//  History-Project-ios
//
//  Created by baby1234 on 08/06/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MapViewModel: ViewModelType {
    let disposeBag = DisposeBag()
    
    struct Input {
        let historySiteCode: BehaviorRelay<String>
        let clickHome: Signal<Void>
        let clickBack: Signal<Void>
        let clickNext: Signal<Void>
    }
    
    struct Output {
        let latAndLng: Driver<(Double,Double)>
        let goVC: BehaviorRelay<GoWhere>
    }
    
    func transform(input: MapViewModel.Input) -> MapViewModel.Output {
        let latAndLng = BehaviorRelay<(Double,Double)>(value: (0.0, 0.0))
        let goVC = BehaviorRelay<GoWhere>(value: .stay)
        let api = MapApi()
        
        input.historySiteCode.asObservable().subscribe { [weak self] code in
            if let code = code.element {
                guard let strongSelf = self else {return}
                api.getMap(historySiteCode: code).subscribe(onNext: { model in
                    guard let model = model else {return}
                    latAndLng.accept((model.latitude, model.longitude))
                }).disposed(by: strongSelf.disposeBag)
            }
        }.disposed(by: disposeBag)
        
        input.clickHome.asObservable().subscribe { _ in
            goVC.accept(.home)
        }.disposed(by: disposeBag)
        
        input.clickBack.asObservable().subscribe { _ in
            goVC.accept(.back)
        }.disposed(by: disposeBag)
        
        input.clickNext.asObservable().subscribe { _ in
            goVC.accept(.next)
        }
        
        return Output(latAndLng: latAndLng.asDriver(), goVC: goVC)
    }
}
