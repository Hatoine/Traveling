//
//  WeatherGpsService.swift
//  TravelApp
//
//  Created by Antoine Antoniol on 26/11/2019.
//  Copyright © 2019 Antoine Antoniol. All rights reserved.
//

import Foundation

final class GpsWeatherService {
     // MARK: - Properties
     
     private let session: URLSession
     private var task: URLSessionDataTask?
     private let apiKey = ApiKeyExtractor().apiKey.openWeatherMap
     // MARK: - Initialization
     
     init(session:URLSession = URLSession(configuration: .default)) {
         self.session = session
     }
     
    func getCurrentPositionWeatherDescription(longitude:Double,latitude:Double,callBack: @escaping (Bool, WeatherData?)->Void) {
        guard let apiUrl = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=metric&APPID=\(apiKey)&lang=fr") else { return }
        
        task?.cancel()
        
        task = session.dataTask(with: apiUrl ) { (data, response, error) in
            
            guard let data = data, error == nil else {
                callBack(false, nil)
                return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callBack(false, nil)
                return }
            
            guard let responseJSON = try? JSONDecoder().decode(WeatherData.self, from: data) else {
                callBack(false, nil)
                return }
            
            callBack(true, responseJSON)
        }
        task?.resume()
    }
}
