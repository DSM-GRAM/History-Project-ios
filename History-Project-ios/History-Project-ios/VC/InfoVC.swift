//
//  File.swift
//  History-Project-ios
//
//  Created by baby1234 on 26/05/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class InfoVC: UIViewController{

    @IBOutlet var upGesture: UISwipeGestureRecognizer!
    @IBOutlet var downGesture: UISwipeGestureRecognizer!
    
    @IBOutlet weak var listBtn: UIButton!
    @IBOutlet weak var toolBarSiteName: UILabel!
    @IBOutlet weak var toolBarImageView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var siteNameLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var textLbl: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var extraTextImageView: UIImageView!
    @IBOutlet weak var extraTextLbl: UILabel!
    @IBOutlet weak var explainLbl: UILabel!
    
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var infoViewModel: InfoViewModel!
    var input: InfoViewModel.Input!
    var output: InfoViewModel.Output!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoViewModel = InfoViewModel()

        input = InfoViewModel.Input(area: BehaviorRelay(value: "bla"), historicalSiteCode: BehaviorRelay(value: "5cbaf424cb48472b2e4dad9a"), clickHome: homeBtn.rx.tap.asSignal(), clickNext: nextBtn.rx.tap.asSignal(), clickList: listBtn.rx.tap.asSignal())
        
        output = infoViewModel.transform(input: input)
        bindOutput(output: output)
        
    }
    
    func bindOutput(output: InfoViewModel.Output) {
        output.explain.drive(explainLbl.rx.text).disposed(by: disposeBag)
        output.extraText.drive(extraTextLbl.rx.text).disposed(by: disposeBag)
        output.imagePath.drive(onNext: { [weak self] (imgPath) in
            guard let strongSelf = self else { return }
            strongSelf.toolBarImageView.image = UIImage(contentsOfFile: imgPath)
        }).disposed(by: disposeBag)
        output.location.drive(locationLbl.rx.text).disposed(by: disposeBag)
        output.text.drive(textLbl.rx.text).disposed(by: disposeBag)
    }
    
    @IBAction func upAction(_ sender: UISwipeGestureRecognizer) {
        
    }
    
    @IBAction func downAction(_ sender: UISwipeGestureRecognizer) {
        
    }
}

extension InfoVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var num: Int = Int()
            
        output.extra.drive(onNext: { (extra) in
            num = extra.count
        }).disposed(by: disposeBag)
        
        return num
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCell", for: indexPath) as! InfoCell
    
        output.extra.drive(onNext: { (extra) in
            cell.extraImageView.image = UIImage(contentsOfFile: extra[indexPath.row].extraImagePath)
            cell.extraNameLbl.text = extra[indexPath.row].extraName
            cell.extraLocationLbl.text = extra[indexPath.row].extraLocation
        }).disposed(by: disposeBag)
        
        return cell
    }
    
    
}

class InfoCell: UICollectionViewCell {
    @IBOutlet weak var extraImageView: UIImageView!
    @IBOutlet weak var extraNameLbl: UILabel!
    @IBOutlet weak var extraLocationLbl: UILabel!
}
