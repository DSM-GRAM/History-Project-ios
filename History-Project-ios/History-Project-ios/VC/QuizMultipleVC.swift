//
//  QuizMultipleVC.swift
//  History-Project-ios
//
//  Created by daeun on 11/06/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class QuizMultipleVC: UIViewController {
    @IBOutlet weak var questionText: UITextView!
    @IBOutlet weak var wordCollectionView: UICollectionView!
    let disposeBag = DisposeBag()
    let question = BehaviorRelay<String>(value: "")
    let answer = BehaviorRelay<String>(value: "")
    let wordList = BehaviorRelay<[String]>(value: [])
    var quizViewModel = QuizViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let quizMultipleViewModel = QuizMultipleViewModel()
        let input = QuizMultipleViewModel.Input(question: question, answer: answer, wordList: wordList, clickIndex: wordCollectionView.rx.itemSelected.asDriver())
        let output = quizMultipleViewModel.transform(input: input)
        
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
        
        output.wordList.drive(wordCollectionView.rx.items(cellIdentifier: "wordCell", cellType: WordCell.self)) { _, data, cell in
            cell.configure(word: data)
        }.disposed(by: disposeBag)
    }
}

class WordCell: UICollectionViewCell {
    @IBOutlet weak var wordLabel: UILabel!
    func configure(word: String) {
        wordLabel.text = word
    }
}
