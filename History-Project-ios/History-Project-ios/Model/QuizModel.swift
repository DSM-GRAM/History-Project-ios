//
//  QuizModel.swift
//  History-Project-ios
//
//  Created by daeun on 11/06/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation

struct QuizModel: Codable {
    
    let multipleAnswer: [String]
    let oxAnswer: [String]?
    let multipleQuestion: [String]
    let oxQuestion: [String]?
    let wordList: [[String]]
    let wordOfNumber: [Int]
    
    enum CodingKeys: String, CodingKey {
        case multipleAnswer
        case oxAnswer
        case multipleQuestion
        case oxQuestion
        case wordList
        case wordOfNumber
    }
}
