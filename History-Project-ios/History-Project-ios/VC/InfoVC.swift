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
import Kingfisher

class InfoVC: UIViewController{

    @IBOutlet var upGesture: UISwipeGestureRecognizer!
    @IBOutlet var downGesture: UISwipeGestureRecognizer!
    
    @IBOutlet weak var listBtn: UIButton!
    @IBOutlet weak var toolBarSiteName: UILabel!
    @IBOutlet weak var toolBarImageView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var siteNameLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var textTextView: UITextView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var extraTextImageView: UIImageView!
    @IBOutlet weak var extraTextTextView: UITextView!
    @IBOutlet weak var explainTextView: UITextView!
    
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var infoViewModel: InfoViewModel!
    var input: InfoViewModel.Input!
    var output: InfoViewModel.Output!
    
    var area: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    var historicalSiteCode: BehaviorRelay<String>! = BehaviorRelay<String>(value: "")
    var historicalSiteName: String = ""
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoViewModel = InfoViewModel()

        input = InfoViewModel.Input(area: area, historicalSiteCode: historicalSiteCode, clickHome: homeBtn.rx.tap.asSignal(), clickNext: nextBtn.rx.tap.asSignal(), clickList: listBtn.rx.tap.asSignal())
        
        output = infoViewModel.transform(input: input)
        binding(output: output)
        uiConfigure()
    }
    
    func binding(output: InfoViewModel.Output) {
        output.explain.drive(explainTextView.rx.text).disposed(by: disposeBag)
        output.extraText.drive(extraTextTextView.rx.text).disposed(by: disposeBag)
        output.imagePath.drive(onNext: { [weak self] (imgPath) in
            guard let strongSelf = self else { return }
            strongSelf.toolBarImageView.kf.setImage(with: URL(string: imgPath),
                                                    options: [.processor(ResizingImageProcessor(referenceSize: CGSize(width: 75, height: 48), mode: .aspectFill))])
            strongSelf.extraTextImageView.kf.setImage(with: URL(string: imgPath),
                                                     options: [(.processor(BlurImageProcessor(blurRadius: 4))),.processor(ResizingImageProcessor(referenceSize: CGSize(width: 67, height: 20), mode: .aspectFill))])
        }).disposed(by: disposeBag)
        output.location.drive(locationLbl.rx.text).disposed(by: disposeBag)
        output.text.drive(textTextView.rx.text).disposed(by: disposeBag)
        
        output.extra.drive(collectionView.rx.items(cellIdentifier: "InfoCell", cellType: InfoCell.self)) { _, data, cell in
            cell.configure(infoModel: data)
        }.disposed(by: disposeBag)
        
        output.goVC.asDriver().drive(onNext: { (state) in
            switch state {
            case .goSiteList :
                self.navigationController?.popViewController(animated: true)
            default : break
            }
        }).disposed(by: disposeBag)
    }
    
    func uiConfigure() {
        textTextView.isScrollEnabled = false
        explainTextView.isScrollEnabled = false
        
        siteNameLbl.text = historicalSiteName
        toolBarSiteName.text = historicalSiteName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func upAction(_ sender: UISwipeGestureRecognizer) {
        
    }
    
    @IBAction func downAction(_ sender: UISwipeGestureRecognizer) {
        
    }
}

class InfoCell: UICollectionViewCell {
    @IBOutlet weak var extraImageView: UIImageView!
    @IBOutlet weak var extraNameLbl: UILabel!
    @IBOutlet weak var extraLocationLbl: UILabel!
    
    func configure(infoModel: InfoModel.Extra) {
        extraImageView.kf.setImage(with: URL(string: infoModel.extraImagePath),
                                   options: [.processor(ResizingImageProcessor(referenceSize: CGSize(width: 70, height: 75), mode: .aspectFill))])
        extraNameLbl.text = infoModel.extraName
        extraLocationLbl.text = infoModel.extraLocation
    }
}
