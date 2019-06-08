//
//  MapAPI.swift
//  History-Project-ios
//
//  Created by baby1234 on 15/05/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation

public enum MapAPI:API {
    case getMap(historySiteCode: String)
    
    func getPath() -> String {
        switch self {
        case .getMap(let historySiteCode):
            return "/map/\(historySiteCode)"
        }
    }
}
