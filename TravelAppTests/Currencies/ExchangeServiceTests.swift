//
//  e.swift
//  TravelAppTests
//
//  Created by Antoine Antoniol on 16/10/2019.
//  Copyright © 2019 Antoine Antoniol. All rights reserved.
//
@ testable import TravelApp
import XCTest

class ExchangeServiceTest: XCTestCase {
    func testGetSymbolsShouldPostFailedCallbackIfError() {
        // Given
        let exchangeService = ExchangeService(
            session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getSymbols(callBack: { (success, symbols) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(symbols)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRatesShouldPostFailedCallbackIfError() {
        // Given
        let exchangeService = ExchangeService(
            session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getRates (devise: "", callBack: { (success, rates) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rates)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGetSymbolsShouldPostFailedCallbackIfNoData() {
        // Given
        let exchangeService = ExchangeService(
            session: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        exchangeService.getSymbols(callBack: { (success, symbols) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(symbols)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetratesShouldPostFailedCallbackIfNoData() {
        // Given
        let exchangeService = ExchangeService(
            session: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getRates (devise: "", callBack: { (success, rates) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rates)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGetSymbolsShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let exchangeService = ExchangeService(
            session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getSymbols(callBack: { (success, symbols) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(symbols)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRatesShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let exchangeService = ExchangeService(
            session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getRates (devise: "", callBack: { (success, rates) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rates)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGetSymbolsShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let exchangeService = ExchangeService(
            session: URLSessionFake(data: FakeResponseData.currenciesCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getSymbols(callBack: { (success, symbols) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(symbols)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRatesShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let exchangeService = ExchangeService(
            session: URLSessionFake(data: FakeResponseData.ratesCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        exchangeService.getRates (devise: "", callBack: { (success, rates) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rates)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetSymbolsShouldPostFailedCallbackIfNoErrorAndCorrectData() {
        // Given
        let exchangeService = ExchangeService(
            session: URLSessionFake(data: FakeResponseData.currenciesCorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getSymbols(callBack: { (success, symbols) in
            // Then
            let currencieSymbol = "USD"
            XCTAssertEqual(currencieSymbol,currencieSymbol)
            XCTAssertTrue(success)
            XCTAssertNotNil(currencieSymbol)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRatesShouldPostFailedCallbackIfNoErrorAndCorrectData() {
        // Given
        let exchangeService = ExchangeService(
            session: URLSessionFake(data: FakeResponseData.ratesCorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getRates (devise: "", callBack: { (success, rates) in
            // Then
            let dayRate = 1.52
            XCTAssertEqual(dayRate,dayRate)
            XCTAssertTrue(success)
            XCTAssertNotNil(dayRate)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
}
