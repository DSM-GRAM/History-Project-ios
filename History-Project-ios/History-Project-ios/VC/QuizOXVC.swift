//
//  QuizOXVC.swift
//  History-Project-ios
//
//  Created by daeun on 11/06/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class QuizOXVC: UIViewController {
    @IBOutlet weak var questionText: UITextView!
    @IBOutlet weak var OButton: UIButton!
    @IBOutlet weak var XButton: UIButton!
    let disposeBag = DisposeBag()
    let question = BehaviorRelay<String>(value: "")
    let answer = BehaviorRelay<String>(value: "")
    var quizViewModel = QuizViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let quizOXViewModel = QuizOXViewModel()
        let input = QuizOXViewModel.Input(question: question, answer: answer, clickO: OButton.rx.tap.asSignal(), clickX: XButton.rx.tap.asSignal())
        let output = quizOXViewModel.transform(input: input)
        
        output.question.drive(questionText.rx.text).disposed(by: disposeBag)
        output.result.subscribe { event in
            if let result = event.element {
                if result {
                    self.showToast(msg: "맞았습니다!")
                    self.quizViewModel.next.accept(())
                } else {
                    self.showToast(msg: "틀렸습니다.")
                    self.view.backgroundColor = .red
                }
            }
        }.disposed(by: disposeBag)
    }
}
