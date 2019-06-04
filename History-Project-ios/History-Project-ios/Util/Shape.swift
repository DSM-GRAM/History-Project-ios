//
//  Shape.swift
//  History-Project-ios
//
//  Created by daeun on 23/05/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation
import UIKit

class RoundButton: UIButton {
    
    override func awakeFromNib() {
        setShape()
    }
    
    func setShape(){
        layer.cornerRadius = frame.height / 2
        layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.init(width: 1, height: 1)
    }
}

class RoundImageView: UIImageView {
    override func awakeFromNib() {
        setShape()
    }
    
    func setShape(){
        layer.cornerRadius = frame.height / 2
    }
}

class Round6ImageView: UIImageView {
    
    override func awakeFromNib() {
        setShape()
    }
    
    func setShape(){
        layer.cornerRadius = frame.height / 6
    }
}
