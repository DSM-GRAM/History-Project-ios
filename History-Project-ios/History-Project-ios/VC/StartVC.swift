//
//  StartVC.swift
//  History-Project-ios
//
//  Created by daeun on 16/05/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class StartVC: UIViewController {
    
    @IBOutlet weak var blaButton: RoundButton!
    @IBOutlet weak var usuButton: RoundButton!
    
    let disposeBag = DisposeBag()
    var startViewModel: StartViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startViewModel = StartViewModel()
        let input = StartViewModel.Input(clickUsu: blaButton.rx.tap.asSignal(),
                                         clickBla: usuButton.rx.tap.asSignal())
        let output = startViewModel.transform(input: input)
        
        output.area.asObservable().subscribe { [weak self] _ in
            guard let strongSelf = self else {return}
            strongSelf.performSegue(withIdentifier: "goHistoricalSiteList", sender: nil)
        }.disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
}
