//
//  HistoricalSiteListVC.swift
//  History-Project-ios
//
//  Created by daeun on 29/05/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class HistoricalSiteListVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var area: String = ""
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let historicalSiteListViewModel = HistoricalSiteListViewModel()
        
        let input = HistoricalSiteListViewModel.Input(area: Driver.of(area), selectedIndex: tableView.rx.itemSelected.asDriver())
        
        let output = historicalSiteListViewModel.transform(input: input)
        
        output.list.drive(tableView.rx.items(cellIdentifier: "cell", cellType: HistoricalSiteListCell.self)) { _, data, cell in
            cell.configure(siteList: data)
            }.disposed(by: disposeBag)
        
        output.selectedSiteCode.asObservable().subscribe { code in
            //todo
            }.disposed(by: disposeBag)
        
        output.area.drive(navigationItem.rx.title).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
}

class HistoricalSiteListCell: UITableViewCell {
    @IBOutlet weak var siteIamgeView: UIImageView!
    @IBOutlet weak var siteNameLabel: UILabel!
    @IBOutlet weak var siteLocationLabel: UILabel!
    
    override func awakeFromNib() {
        selectionStyle = .none
    }
    
    func configure(siteList: HistoricalSiteListModel) {
        self.siteIamgeView.kf.setImage(with: URL(string: siteList.imagePath),
                                       options: [(.processor(BlurImageProcessor(blurRadius: 4))),.processor(ResizingImageProcessor(referenceSize: CGSize(width: 52, height: 16), mode: .aspectFill))])
        self.siteNameLabel.text = siteList.name
        self.siteLocationLabel.text = siteList.location
    }
}
