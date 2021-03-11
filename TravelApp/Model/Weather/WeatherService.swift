//
//  WeatherService.swift
//  TravelApp
//
//  Created by Antoine Antoniol on 18/10/2019.
//  Copyright © 2019 Antoine Antoniol. All rights reserved.
//

import Foundation

final class WeatherService {
    
    // MARK: - Properties
    
    private let session: URLSession
    private var task: URLSessionDataTask?
    
    // MARK: - Initialization
    
    init(session:URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    // MARK: - Methods
    
    private func weatherUrl(city:String) -> String {
        let apiKey = ApiKeyExtractor().apiKey.openWeatherMap
        let lang = "fr"
        let unit = "metric"
        let url = "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&lang=\(lang)&units=\(unit)"
        return url
    }
    
    /// Network call to get weather description
    
    func getWeatherDescription(city:String,callBack: @escaping (Bool, WeatherData?)->Void) {

        guard let apiUrl = URL(string: weatherUrl(city: city)) else { return }
       
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
