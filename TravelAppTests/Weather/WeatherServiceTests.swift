//
//  WeatherServiceTests.swift
//  TravelAppTests
//
//  Created by Antoine Antoniol on 28/10/2019.
//  Copyright © 2019 Antoine Antoniol. All rights reserved.
//

@ testable import TravelApp
import XCTest

class WeatherServiceTests: XCTestCase {
    func testGetWeatherShouldPostFailedCallbackIfError() {
        // Given
        let weatherService = WeatherService(
            session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeatherDescription(callBack: { (success, weatherData) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherData)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        // Given
        let weatherService = WeatherService(
            session: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeatherDescription (callBack: { (success, weatherData) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherData)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let weatherService = WeatherService(
            session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeatherDescription (callBack: { (success, weatherData) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherData)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let weatherService = WeatherService(
            session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weatherService.getWeatherDescription(callBack: { (success, weatherData) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherData)
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfNoErrorAndCorrectData() {
        // Given
        let weatherService = WeatherService(
            session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeatherDescription(callBack: { (success, weatherData) in
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
