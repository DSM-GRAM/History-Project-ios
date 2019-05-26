//
//  InfoModel.swift
//  History-Project-ios
//
//  Created by baby1234 on 26/05/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation
import ObjectMapper

class InfoModel: Mappable {
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        explain <- map["explain"]
        extraText <- map["extraText"]
        imagePath <- map["imagePath"]
        location <- map["location"]
        text <- map["text"]
    }
    
    var explain: String?
    var extraText: String?
    var imagePath: String?
    var location: String?
    var text: String?
    
    class ExtraModel: Mappable {
        required init?(map: Map) { }
        
        func mapping(map: Map) {
            extraImagePath <- map["extraImagePath"]
            extraLocation <- map["extraLocation"]
            extraName <- map["extraName"]
        }
        var extraImagePath: String?
        var extraLocation: String?
        var extraName: String?
    }
}
