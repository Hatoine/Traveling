//
//  TranslationStruct.swift
//  TravelApp
//
//  Created by Antoine Antoniol on 29/10/2019.
//  Copyright © 2019 Antoine Antoniol. All rights reserved.
//

import Foundation

// MARK: - Empty

struct TranslateData: Decodable {
    let data: DataClass
}

// MARK: - DataClass

struct DataClass: Decodable {
    let translations: [Translation]
}

// MARK: - Translation

struct Translation: Decodable {
    let translatedText: String
}
