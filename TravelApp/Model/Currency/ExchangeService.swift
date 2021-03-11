//
//  QuoteService.swift
//  TravelApp
//
//  Created by Antoine Antoniol on 24/09/2019.
//  Copyright © 2019 Antoine Antoniol. All rights reserved.
//

import Foundation

final class ExchangeService {
    
    // MARK: - Properties
    
    private let apiKey = ApiKeyExtractor().apiKey.fixer
    private var task: URLSessionDataTask?
    private let session: URLSession
    
    // MARK: - Initialization
    
    init(session:URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    // MARK: - Methods
    
    /// Network call to get currencies symbols
    
    func getSymbols(callBack: @escaping (Bool, Symbols?)->Void) {
        
        guard let symbolsUrl = URL(string: "http://data.fixer.io/api/symbols?access_key=\(apiKey)") else { return }
        
        task?.cancel()
        
        task = session.dataTask(with: symbolsUrl) { (data, response, error) in
            
            guard let data = data, error == nil else {
                callBack(false, nil)
                return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callBack(false, nil)
                return }
            
            guard let responseJSON = try? JSONDecoder().decode(Symbols.self, from: data) else {
                callBack(false, nil)
                return }
            DispatchQueue.main.async {
                callBack(true, responseJSON)
            }
        }
        task?.resume()
    } 
    
    /// Network call to get rates values
    
    func getRates(devise: String, callBack: @escaping (Bool, Rates?)->Void) {
        
        guard let ratesUrl = URL(string: "http://data.fixer.io/api/latest?access_key=\(apiKey)&base=EUR&symbols=\(devise)") else { return }
        
        task?.cancel()
        
        task = session.dataTask(with: ratesUrl) { (data, response, error) in
            
            guard let data = data, error == nil else {
                callBack(false, nil)
                return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callBack(false, nil)
                return }
            
            guard let responseJSON = try? JSONDecoder().decode(Rates.self, from: data) else {
                callBack(false, nil)
                return }
            DispatchQueue.main.async {
                
                callBack(true, responseJSON)
            }
        }
        task?.resume()
    }
}
