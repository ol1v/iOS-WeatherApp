//
//  CityNames.swift
//  Labb1Swift
//
//  Created by Oliver Lennartsson on 2020-02-19.
//  Copyright © 2020 Oliver Lennartsson. All rights reserved.
//

import Foundation

struct CityNames: Codable {
    let cities: [Name]
}

struct Name: Codable {
    let name: String
}

