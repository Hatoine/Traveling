//
//  TranslationService.swift
//  TravelApp
//
//  Created by Antoine Antoniol on 29/10/2019.
//  Copyright © 2019 Antoine Antoniol. All rights reserved.
//

import Foundation

final class TranslationService {
    
    // MARK: - Properties
    
    private let session: URLSession
    private var task: URLSessionDataTask?
    
    // MARK: - Initialization
    
    init(session:URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
   // MARK: - Methods
    
    private func translationUrl(quote:String) -> String {
        let apiKey = ApiKeyExtractor().apiKey.googleTranslate
        let source = "fr"
        let target = "en"
        guard let text = quote.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return ""}
        let apiURL = "https://translation.googleapis.com/language/translate/v2?q=\(text)&target=\(target)&format=text&source=\(source)&key=\(apiKey)"
        return apiURL
    }
    
    /// Network call to get translation
    
    func getTranslation(input: String, callBack: @escaping (Bool, TranslateData?)->Void) {
        
        guard let apiUrl = URL(string: translationUrl(quote: input) ) else { return }
        
        task?.cancel()
        
        task = session.dataTask(with: apiUrl ) { (data, response, error) in
            
            guard let data = data, error == nil else {
                callBack(false, nil)
                return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callBack(false, nil)
                return }
            
            guard let responseJSON = try? JSONDecoder().decode(TranslateData.self, from: data) else {
                callBack(false, nil)
                return }
            DispatchQueue.main.async {
                callBack(true, responseJSON)
            }
        }
        task?.resume()
    }
}
