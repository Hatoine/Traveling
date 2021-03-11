//
//  RatesStruct.swift
//  TravelApp
//
//  Created by Antoine Antoniol on 28/10/2019.
//  Copyright © 2019 Antoine Antoniol. All rights reserved.
//

import Foundation

struct Symbols: Decodable {
    let symbols: [String:String]
}

struct Rates: Decodable {
    let rates: [String:Double]
}
