//
//  MapModel.swift
//  History-Project-ios
//
//  Created by baby1234 on 07/06/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation

struct MapModel: Codable {
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}
