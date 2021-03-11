//
//  ApiKeyExtractor.swift
//  TravelApp
//
//  Created by Antoine Antoniol on 07/11/2019.
//  Copyright © 2019 Antoine Antoniol. All rights reserved.
//

import Foundation

final class ApiKeyExtractor {
    var apiKey: ApiKey {
        guard let path = Bundle.main.path(forResource: "ApiKeys", ofType: "plist"), let data = FileManager.default.contents(atPath: path) else {
            fatalError("can't find ApiKeys.plist")
        }
        guard let dataExtracted = try? PropertyListDecoder().decode(ApiKey.self, from: data) else {
            fatalError("can't load data from ApiKeys.plist")
        }
        return dataExtracted
    }
    
}

struct ApiKey: Decodable {
    let fixer: String
    let googleTranslate: String
    let openWeatherMap: String
}
