//
//  MapVC.swift
//  History-Project-ios
//
//  Created by baby1234 on 04/06/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher
import GoogleMaps
import CoreLocation

class MapVC: UIViewController {
    
    @IBOutlet weak var googlemapBtn: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var mapBackgroundView: UIView!
    
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: RoundButton!
    
    let disposeBag = DisposeBag()
    
    var mapViewModel: MapViewModel!
    var historySiteCode: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    var backgroudImgPath: String = ""
    var historySiteName: String = ""
    var historySiteLocation: String = ""
    var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapViewModel = MapViewModel()
        
        let input = MapViewModel.Input(historySiteCode: historySiteCode, clickHome: homeBtn.rx.tap.asSignal() , clickBack: backBtn.rx.tap.asSignal(), clickNext: nextBtn.rx.tap.asSignal())
        let output = mapViewModel.transform(input: input)
        
        backgroundImageView.kf.setImage(with: URL(string: backgroudImgPath),
                                        options: [.processor(ResizingImageProcessor(referenceSize: CGSize(width: backgroundImageView.frame.width / 2, height: backgroundImageView.frame.height / 2), mode: .aspectFill))])
        
        binding(output: output)
    }
    
    func mapConfig(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 15.0)
        mapView = GMSMapView.map(withFrame: mapBackgroundView.bounds, camera: camera)
        mapBackgroundView.addSubview(mapView)
        
        let marker = GMSMarker()
        marker.position = camera.target
        marker.title = historySiteName
        marker.snippet = historySiteLocation
        marker.tracksInfoWindowChanges = false
        marker.map = mapView
    }
    
    func binding(output: MapViewModel.Output) {
        output.latAndLng.drive(onNext: { [weak self] lat, lng in
            guard let strongSelf = self else {return}
            strongSelf.mapConfig(latitude: lat, longitude: lng)
        }).disposed(by: disposeBag)
        
        output.goVC.asDriver().drive(onNext: { [weak self] state in
            guard let strongSelf = self else {return}
            switch state {
            case .home: strongSelf.navigationController?.popToRootViewController(animated: true)
            case .back: strongSelf.navigationController?.popViewController(animated: true)
            case .next: strongSelf.performSegue(withIdentifier: "goQuiz", sender: nil)
            default: return
            }
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
}
