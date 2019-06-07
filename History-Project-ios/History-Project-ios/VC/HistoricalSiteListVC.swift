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
    var name: String = ""
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let historicalSiteListViewModel = HistoricalSiteListViewModel()
        
        let input = HistoricalSiteListViewModel.Input(area: Driver.of(area), selectedIndex: tableView.rx.itemSelected.asDriver())
        
        let output = historicalSiteListViewModel.transform(input: input)
        
        output.list.drive(tableView.rx.items(cellIdentifier: "cell", cellType: HistoricalSiteListCell.self)) { _, data, cell in
            cell.configure(siteList: data)
        }.disposed(by: disposeBag)
        
        output.selectedSiteCodeAndName.asObservable().subscribe { [weak self] codeAndName in
            guard let strongSelf = self else {return}
            
            if let (code, name) = codeAndName.element {
                strongSelf.name = name
                strongSelf.performSegue(withIdentifier: "goInfo", sender: code)
            }
        }.disposed(by: disposeBag)
        
        output.area.drive(navigationItem.rx.title).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goInfo" {
            let vc = segue.destination as! InfoVC
            vc.area.accept(area)
            guard let code = sender as? String else { return }
            vc.historicalSiteCode.accept(code)
            vc.historicalSiteName = name
        }
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
                                       options: [(.processor(BlurImageProcessor(blurRadius: 4))),.processor(ResizingImageProcessor(referenceSize: CGSize(width: 42, height: 45), mode: .aspectFill))])
        self.siteNameLabel.text = siteList.name
        self.siteLocationLabel.text = siteList.location
    }
}
