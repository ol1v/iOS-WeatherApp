//
//  WeatherData.swift
//  Labb1Swift
//
//  Created by Oliver Lennartsson on 2020-02-17.
//  Copyright © 2020 Oliver Lennartsson. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let main: Main
    let name: String
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let icon: String
}

/*let jsonWeather = jsonResponse["weather"].array![0]
let jsonTemp = jsonResponse["main"]
let iconName = jsonWeather["icon"].stringValue

let temperature = "\(Int(round(jsonTemp["temp"].doubleValue)))"

weather = ["location": jsonResponse["name"].stringValue,
               "condition": jsonWeather["main"].stringValue,
               "temperature": "\(temperature)",
               "icon": iconName]*/
