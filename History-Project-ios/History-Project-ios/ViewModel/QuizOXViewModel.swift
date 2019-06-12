//
//  QuizOXViewModel.swift
//  History-Project-ios
//
//  Created by daeun on 11/06/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class QuizOXViewModel: ViewModelType {
    struct Input {
        let question: BehaviorRelay<String>
        let answer: BehaviorRelay<String>
        let clickO: Signal<Void>
        let clickX: Signal<Void>
    }
    
    struct Output {
        let question: Driver<String>
        let result: Observable<Bool>
    }
    
    func transform(input: QuizOXViewModel.Input) -> QuizOXViewModel.Output {
        
        let clickO = input.clickO.asObservable().map {"O"}
        let clickX = input.clickX.asObservable().map {"X"}
        
        let userAnswer = Observable.of(clickO,clickX).merge()
        
        let result = Observable.combineLatest(userAnswer, input.answer.asObservable(),resultSelector: {
            return $0 == $1
        })
        
        return Output(question: input.question.asDriver(), result: result)
    }
}
