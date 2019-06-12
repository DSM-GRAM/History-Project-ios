//
//  QuizViewModel.swift
//  History-Project-ios
//
//  Created by daeun on 11/06/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class QuizViewModel: ViewModelType {
    let next = PublishRelay<Void>()
    let start = PublishRelay<Void>()
    let disposeBag = DisposeBag()
    
    struct Input {
        let historycalSiteCode: BehaviorRelay<String>
    }
    
    struct Output {
        let showOX: PublishRelay<OXQA>
        let showMultiple: PublishRelay<MultipleQA>
        let goHome: PublishRelay<Void>
    }
    
    func transform(input: Input) -> Output {
        let api = QuizApi()
        let oxQuestion = BehaviorRelay<[String]>(value: [])
        let oxAnswer = BehaviorRelay<[String]>(value: [])
        let multipleQuestion = BehaviorRelay<[String]>(value: [])
        let multipleAnswer = BehaviorRelay<[String]>(value: [])
        let multipleWordList = BehaviorRelay<[[String]]>(value: [[]])
        let showOX = PublishRelay<OXQA>()
        let showMultiple = PublishRelay<MultipleQA>()
        var oxNum = 0
        var multipleNum = 0
        let goHome = PublishRelay<Void>()
        
        api.getQuiz(historySiteCode: input.historycalSiteCode.value).subscribe { [weak self] event in
            guard let strongSelf = self else {return}
            if let model = event.element {
                if let model = model {
                    oxQuestion.accept(model.oxQuestion ?? [])
                    oxAnswer.accept(model.oxAnswer ?? [])
                    multipleQuestion.accept(model.multipleQuestion)
                    multipleAnswer.accept(model.multipleAnswer)
                    multipleWordList.accept(model.wordList)
                    strongSelf.start.accept(())
                }
            }
        }.disposed(by: disposeBag)
        
        next.asObservable().subscribe { _ in
            if oxNum < oxQuestion.value.count {
                showOX.accept(OXQA(question: oxQuestion.value[oxNum], answer: oxAnswer.value[oxNum]))
                oxNum = oxNum + 1
            } else if multipleNum < multipleQuestion.value.count{
                showMultiple.accept(MultipleQA(question: multipleQuestion.value[multipleNum], answer: multipleAnswer.value[multipleNum], wordList: multipleWordList.value[multipleNum]))
                multipleNum = multipleNum + 1
            } else {
                goHome.accept(())
            }
        }.disposed(by: disposeBag)
        
        return Output(showOX: showOX, showMultiple: showMultiple, goHome: goHome)
    }
}

struct OXQA {
    let question: String
    let answer: String
}

struct MultipleQA {
    let question: String
    let answer: String
    let wordList: [String]
}
