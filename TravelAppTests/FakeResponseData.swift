//
//  FakeResponseData.swift
//  TravelAppTests
//
//  Created by Antoine Antoniol on 16/10/2019.
//  Copyright © 2019 Antoine Antoniol. All rights reserved.
//

import Foundation

class FakeResponseData {
    
    // MARK: - Data
    
    static var ratesCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Rates", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static var currenciesCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Currencies", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static var weatherCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static var GpsweatherCorrectData: Data? {
           let bundle = Bundle(for: FakeResponseData.self)
           let url = bundle.url(forResource: "Weather", withExtension: "json")!
           return try! Data(contentsOf: url)
       }
    
    
    static var translateCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static let incorrectData = "error".data(using: .utf8)
    
    
    // MARK: - Respons
    
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    
    // MARK: - Error
    
    class FakeError: Error {}
    static let error = FakeError()
}


