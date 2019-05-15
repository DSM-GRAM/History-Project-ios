//
//  MAinAPI.swift
//  History-Project-ios
//
//  Created by baby1234 on 15/05/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation

public enum MainAPI:API {
    case getHistorySiteList(area: String)
    case getHistorySiteDetail(area: String, historySiteCode: String)
    
    func getPath() -> String {
        switch self {
        case .getHistorySiteList(let area):
            return "/main/\(area)"
        case .getHistorySiteDetail(let area, let historySiteCode):
            return "/main/\(area)/\(historySiteCode)"
        }
    }
}
