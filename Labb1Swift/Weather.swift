//
//  Weather.swift
//  Labb1Swift
//
//  Created by Oliver Lennartsson on 2020-02-11.
//  Copyright © 2020 Oliver Lennartsson. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import CoreLocation


    struct WeatherApi {
    
    func updateWeatherOnPosition(lat: Double, lon: Double, completion: @escaping( Result<WeatherData, Error>) -> Void) {
        
        let API_KEY: String = "a131ab9c58453d5725f099064cd5b2c4"
        let latitude = lat
        let longitude = lon
        // API Request
        let task = AF.request("http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(API_KEY)&units=metric").responseJSON {
            response in
            if let responseError = response.error {
                print("Something went wrong. Error: \(responseError)")
                completion(.failure(responseError))
                return
            }
            
            if let responseStr = response.data {
                do{
                    //let jsonResponse: WeatherData = JSON(responseStr)
                    let decoder = JSONDecoder()
                    let weather: WeatherData = try decoder.decode(WeatherData.self, from: responseStr)
                    print("Weather: \(weather.main)")
                    completion(.success(weather))
                    return
                } catch {
                    print("Couldn't parse json")
                }
            }
        }
        task.resume()
    }
}

