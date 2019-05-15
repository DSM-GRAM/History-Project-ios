//
//  QuizAPI.swift
//  History-Project-ios
//
//  Created by baby1234 on 15/05/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation

public enum QuizAPI: API {
    case getQuiz(historySiteCode: String)
    
    func getPath() -> String {
        switch self {
        case .getQuiz(let historySiteCode):
            return "/quiz/\(historySiteCode)"
        }
    }
}
