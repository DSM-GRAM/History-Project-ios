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
    func getHistoricalSiteList(area: String) -> Observable<[HistoricalSiteListModel]>
}

protocol MapProvider {
    
}

protocol QuizProvider {
    
}

class MainApi: MainProvider {
    
    let httpClient = HTTPClient()
    
    func getHistoricalSiteList(area: String) -> Observable<[HistoricalSiteListModel]> {
        return httpClient.get(url: MainAPI.getHistorySiteList(area: area).getPath(),
                              params: nil).map { (response, data) -> [HistoricalSiteListModel] in
                                
                                if response.statusCode == 200 {
                                    guard let model = try? JSONDecoder().decode([HistoricalSiteListModel].self, from: data) else {
                                        print("ERROR")
                                        return []
                                    }
                                    return model
                                }
                                return []
        }
    }
}
