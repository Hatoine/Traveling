//
//  GpsWeatherServiceTests.swift
//  TravelAppTests
//
//  Created by Antoine Antoniol on 27/11/2019.
//  Copyright © 2019 Antoine Antoniol. All rights reserved.
//

import Foundation

@ testable import TravelApp
import XCTest

class GpsWeatherServiceTests: XCTestCase {
    func testGetWeatherShouldPostFailedCallbackIfError() {
        // Given
        let gpsWeatherService = GpsWeatherService(
            session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        gpsWeatherService.getCurrentPositionWeatherDescription(longitude: 10, latitude: 50, callBack: { (success, gpsWeatherStruc) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(gpsWeatherStruc)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        // Given
        let gpsWeatherService = GpsWeatherService(
            session: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        gpsWeatherService.getCurrentPositionWeatherDescription(longitude: 10, latitude: 50, callBack: { (success, gpsWeatherStruc) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(gpsWeatherStruc)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let gpsWeatherService = GpsWeatherService(
            session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        gpsWeatherService.getCurrentPositionWeatherDescription(longitude: 10, latitude: 50, callBack: { (success, gpsWeatherStruc) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(gpsWeatherStruc)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let gpsWeatherService = GpsWeatherService(
            session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        gpsWeatherService.getCurrentPositionWeatherDescription(longitude: 10, latitude: 50, callBack: { (success, gpsWeatherStruc) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(gpsWeatherStruc)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfNoErrorAndCorrectData() {
        // Given
        let gpsWeatherService = GpsWeatherService(
            session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        gpsWeatherService.getCurrentPositionWeatherDescription(longitude: 10, latitude: 50, callBack: { (success, gpsWeatherStruc) in
            // Then
            let weatherCity = "New York"
            XCTAssertEqual(weatherCity,weatherCity)
            XCTAssertTrue(success)
            XCTAssertNotNil(weatherCity)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 0.01)
    }
}
