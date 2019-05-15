//
//  API.swift
//  History-Project-ios
//
//  Created by baby1234 on 15/05/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation
import RxSwift

protocol ImageProvider {
    
}

protocol MainProvider {
    
}

protocol MapProvider {
    
}

protocol QuizProvider {
    
}

protocol ApiProvider: ImageProvider, MainProvider, MapProvider, QuizProvider {  }

class Api: ApiProvider {
    private let httpClient = HTTPClient()
    
    
}
