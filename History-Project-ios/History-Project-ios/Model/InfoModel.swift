//
//  InfoModel.swift
//  History-Project-ios
//
//  Created by baby1234 on 26/05/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation

struct InfoModel: Codable {
    let explain: String
    let extra: [Extra]
    let extraText: String
    let imagePath: String
    let location: String
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case explain
        case extra
        case extraText
        case imagePath
        case location
        case text
    }
    
    struct Extra: Codable {
        let extraName: String
        let extraImagePath: String
        let extraLocation: String
        
        enum CodingKeys: String, CodingKey {
            case extraName
            case extraImagePath
            case extraLocation
        }
    }
}

