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
    func getHistoricalSiteList(area: String) -> Observable<[HistoricalSiteListModel]>
}

protocol MapProvider {
    func getMap(historySiteCode:String) -> Observable<MapModel?>
}

protocol QuizProvider {
    
}

class MainApi: MainProvider {
    let httpClient = HTTPClient()
    
    func getInfo(area: String, historySiteCode: String) -> Observable<InfoModel?> {
        let infoPath = MainAPI.getHistorySiteDetail(area: area, historySiteCode: historySiteCode).getPath()
        
        return httpClient.get(url: infoPath, params: nil).map { (response, data) -> InfoModel? in
            switch response.statusCode {
            case 200 :
                guard let model = try? JSONDecoder().decode(InfoModel.self, from: data) else {
                    return nil
                }
                return model
            default : return nil
            }
        }
    }
    
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

class MapApi: MapProvider {
    let httpClient = HTTPClient()
    
    func getMap(historySiteCode: String) -> Observable<MapModel?> {
        return httpClient.get(url: MapAPI.getMap(historySiteCode: historySiteCode).getPath(), params: nil)
            .map({ (response, data) -> MapModel? in
                if response.statusCode == 200 {
                    guard let model = try? JSONDecoder().decode(MapModel.self, from: data) else {return nil}
                    return model
                }
                return nil
            })
    }
}
