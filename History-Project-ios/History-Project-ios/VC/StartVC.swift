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
    var area = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startViewModel = StartViewModel()
        let input = StartViewModel.Input(clickUsu: usuButton.rx.tap.asSignal(),
                                         clickBla: blaButton.rx.tap.asSignal())
        let output = startViewModel.transform(input: input)
        
        output.area.asObservable().subscribe { [weak self] area in
            guard let strongSelf = self else {return}
            strongSelf.area = area.element ?? ""
            strongSelf.performSegue(withIdentifier: "goHistoricalSiteList", sender: nil)
            }.disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goHistoricalSiteList" {
            let vc = segue.destination as? HistoricalSiteListVC
            vc?.area = area
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
}
