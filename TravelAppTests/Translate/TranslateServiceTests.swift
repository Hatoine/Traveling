//
//  File.swift
//  TravelAppTests
//
//  Created by Antoine Antoniol on 30/10/2019.
//  Copyright © 2019 Antoine Antoniol. All rights reserved.
//

import Foundation

@ testable import TravelApp
import XCTest

class TranslateServiceTests: XCTestCase {
    
    func testGetTranslateShouldPostFailedCallbackIfError() {
        // Given
        let translateService = TranslationService(
            session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(input:"Bonjour",callBack: { (success, translateData) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translateData)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfNoData() {
        // Given
        let translateService = TranslationService(
            session: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(input: "Bonjour", callBack: { (success, translateData) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translateData)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetTranslateShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let translateService = TranslationService(
            session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translateService.getTranslation(input: "Bonjour", callBack: { (success, translateData) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translateData)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let translateService = TranslationService(
            session: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translateService.getTranslation(input: "Bonjour", callBack: { (success, translateData) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translateData)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslatehouldPostFailedCallbackIfNoErrorAndCorrectData() {
        // Given
        let translateService = TranslationService(
            session: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseOK, error: nil))
        let translatedText = "Hello"
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(input: "Bonjour", callBack: { (success, translateData) in
            // Then
            XCTAssertTrue(success)
            XCTAssertEqual(translatedText,translatedText)
            XCTAssertNotNil(translatedText)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 0.01)
    }
}
