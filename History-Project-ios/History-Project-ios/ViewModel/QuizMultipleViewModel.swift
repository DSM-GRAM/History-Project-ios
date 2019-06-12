//
//  QuizMultipleViewModel.swift
//  History-Project-ios
//
//  Created by daeun on 11/06/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class QuizMultipleViewModel: ViewModelType {
    struct Input {
        let question: BehaviorRelay<String>
        let answer: BehaviorRelay<String>
        let wordList: BehaviorRelay<[String]>
        let clickIndex: Driver<IndexPath>
    }
    
    struct Output {
        let question: Driver<String>
        let wordList: Driver<[String]>
        let result: Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        
        let userAnswer = Observable.combineLatest(input.clickIndex.asObservable(), input.wordList.asObservable(),resultSelector: {index, wordList in
            return wordList[index.row]
        })
        
        let result = Observable.combineLatest(userAnswer, input.answer.asObservable()) {
            return $0 == $1
        }
        return Output(question: input.question.asDriver(), wordList: input.wordList.asDriver(), result: result)
    }
}
