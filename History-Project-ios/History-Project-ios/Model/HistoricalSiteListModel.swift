//
//  HistoricalSiteListModel.swift
//  History-Project-ios
//
//  Created by daeun on 29/05/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation

struct HistoricalSiteListModel: Codable {
    let name: String
    let location: String
    let imagePath: String
    let code: String
    
    enum CodingKeys: String, CodingKey {
        case name = "historicalSiteName"
        case location = "historicalSiteLocation"
        case imagePath = "historicalSiteImagePath"
        case code = "historicalSiteCode"
    }
}
