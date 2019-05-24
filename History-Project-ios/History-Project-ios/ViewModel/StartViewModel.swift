//
//  StartViewModel.swift
//  History-Project-ios
//
//  Created by daeun on 23/05/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class StartViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    
    struct Input {
        let clickUsu: Signal<Void>
        let clickBla: Signal<Void>
    }
    
    struct Output {
        let area: PublishRelay<String>
    }
    
    func transform(input: Input) -> Output {
        let area = PublishRelay<String>()
        
        input.clickUsu.asObservable().subscribe { _ in
            area.accept("usu")
        }.disposed(by: disposeBag)
        
        input.clickBla.asObservable().subscribe { _ in
            area.accept("bla")
        }.disposed(by: disposeBag)
        
        return Output(area: area)
    }
}
