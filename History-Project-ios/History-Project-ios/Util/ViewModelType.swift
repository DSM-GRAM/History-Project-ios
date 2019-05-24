//
//  ViewModelType.swift
//  History-Project-ios
//
//  Created by daeun on 23/05/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
