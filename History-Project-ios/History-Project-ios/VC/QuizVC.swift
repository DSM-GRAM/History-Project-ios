//
//  QuizVC.swift
//  History-Project-ios
//
//  Created by baby1234 on 09/06/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class QuizVC: UIViewController {
    @IBOutlet weak var quizView: UIView!
    
    let disposeBag = DisposeBag()
    let historicalSiteCode = BehaviorRelay<String>(value: "")
    let nextRelay = PublishRelay<Void>()
    var quizViewModel: QuizViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizViewModel = QuizViewModel()
        let input = QuizViewModel.Input(historycalSiteCode: historicalSiteCode)
        let output = quizViewModel.transform(input: input)
        
        output.showOX.asObservable().subscribe { [weak self] event in
            guard let strongSelf = self else {return}
            if let oxQA = event.element {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "quizOX") as? QuizOXVC
                if let vc = vc {
                    vc.question.accept(oxQA.question)
                    vc.answer.accept(oxQA.answer)
                    vc.quizViewModel = strongSelf.quizViewModel
                    strongSelf.quizView.addSubview(vc.view)
                }
            }
        }.disposed(by: disposeBag)
        
        output.showMultiple.asObservable().subscribe { [weak self] event in
            guard let strongSelf = self else {return}
            if let multipleQA = event.element {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "quizMultiple") as? QuizMultipleVC
                if let vc = vc {
                    vc.question.accept(multipleQA.question)
                    vc.answer.accept(multipleQA.answer)
                    vc.wordList.accept(multipleQA.wordList)
                    vc.quizViewModel = strongSelf.quizViewModel
                    strongSelf.quizView.addSubview(vc.view)
                }
            }
        }.disposed(by: disposeBag)
        
        output.goHome.asObservable().subscribe { [weak self] _ in
            guard let strongSelf = self else {return}
            strongSelf.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)
        
        quizViewModel.start.asObservable().subscribe { [weak self] _ in
            guard let strongSelf = self else {return}
            strongSelf.quizViewModel.next.accept(())
        }.disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Quiz"
    }
}
