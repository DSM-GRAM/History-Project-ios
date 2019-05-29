//
//  API.swift
//  History-Project-ios
//
//  Created by baby1234 on 15/05/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire

protocol ImageProvider {
    
}

protocol MainProvider {
    func getInfo(area:String, historySiteCode:String) -> Observable<InfoModel?>
}

protocol MapProvider {
    
}

protocol QuizProvider {
    
}

class MainApi: MainProvider {
    func getInfo(area: String, historySiteCode: String) -> Observable<InfoModel?> {
        let infoPath = MainAPI.getHistorySiteDetail(area: area, historySiteCode: historySiteCode).getPath()
        let httpClient = HTTPClient()
        
        return httpClient.get(url: infoPath, params: nil).map { (response, data) -> InfoModel? in
            switch response.statusCode {
            case 200 :
                let jsonString = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                if let jsonString = jsonString {
                    let model = InfoModel(JSON: jsonString)
                    
                    return model
                }
                
                return nil
                
            default : return nil
            }
        }
    }
}
