//
//  MapVC.swift
//  History-Project-ios
//
//  Created by baby1234 on 04/06/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit

class MapVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
}
