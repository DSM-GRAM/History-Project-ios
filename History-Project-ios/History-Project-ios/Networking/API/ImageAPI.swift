//
//  ImageAPI.swift
//  History-Project-ios
//
//  Created by baby1234 on 15/05/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation

public enum ImageAPI: API {
    
    case getImage(area: String, imageName: String)
    
    func getPath() -> String {
        switch self {
        case .getImage(let area, let imageName):
            return "/image/\(area)/\(imageName)"
        }
    }
}
