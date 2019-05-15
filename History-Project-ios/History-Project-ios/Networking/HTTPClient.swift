//
//  HTTPClient.swift
//  History-Project-ios
//
//  Created by baby1234 on 15/05/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation
import RxAlamofire
import Alamofire
import RxSwift

protocol HTTPClientProvider {
    func get(url: String, params: Parameters?) -> Observable<(HTTPURLResponse, Data)>
}

final class HTTPClient: HTTPClientProvider {
    let baseURL = "http://52.199.207.14"
    
    func get(url: String, params: Parameters?) -> Observable<(HTTPURLResponse, Data)> {
        return requestData(.get,
                           baseURL + url,
                           parameters: params,
                           encoding: URLEncoding.queryString,
                           headers: ["Content-Type" : "application/json"])
    }
}
