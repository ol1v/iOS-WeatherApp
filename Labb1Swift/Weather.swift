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
        var CityName: String = ""
        var CityCondition: String = ""
        var CityTemp: Double = 0
        let API_KEY: String = "a131ab9c58453d5725f099064cd5b2c4"
        
        // leave city as nil to use coordinates. If city parameter has value
        // API Request is based on city
        func updateWeather(lat: Double, lon: Double, city: String?, completion: @escaping( Result<WeatherData, Error>) -> Void) {
        
        let latitude = lat
        let longitude = lon
        let myCity: String? = city
        let noCity: String = "nocity"
        var myURL: String
        let urlWithCoordinates = "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(API_KEY)&units=metric"
        //let urlWithCity = "api.openweathermap.org/data/2.5/weather?q=\(myCity)&appid=\(API_KEY)&units=metric"
            
        let cityGotValue = myCity ?? noCity
        
            if cityGotValue.contains(noCity) {
                myURL = urlWithCoordinates
            } else {
                print(cityGotValue)
                myURL = "http://api.openweathermap.org/data/2.5/weather?q=\(cityGotValue)&appid=\(API_KEY)&units=metric"
                
            }
        // API Request
        let task = AF.request(myURL).responseJSON {
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
                    completion(.success(weather))
                    return
                } catch {
                    print("Couldn't parse json")
                }
            }
        }
        task.resume()
    }
        /*func getWeather(url: String) -> Void {
           //(APIRequest) updateWeatherOnPosition(url: String) { (result) in
                switch result {
                case .success(let WeatherData):
                    DispatchQueue.main.async {
                        // Uppdatera UI
                        self.CityName = WeatherData.name
                        self.CityCondition = WeatherData.weather.description
                    }
                case .failure(let error): print("Error: \(error)")
                    }
            }
        }*/
        // Fixa senare
        func weatherRequest(latitude: Double, longitude: Double) {
            
            let url = "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(API_KEY)&units=metric"
            
            // getWeather(urlWithCoordinates)
        }
        func weatherRequest(cityname: String) {}
}

