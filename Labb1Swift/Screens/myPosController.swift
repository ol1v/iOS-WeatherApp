//
//  myPosController.swift
//  Labb1Swift
//
//  Created by Oliver Lennartsson on 2020-02-13.
//  Copyright © 2020 Oliver Lennartsson. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation

class myPosController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    
    let gradientLayer = CAGradientLayer()
    let locationManager = CLLocationManager()
    var lat = 11.343434
    var lon = 184.123232
    let iconURL: String = "http://openweathermap.org/img/wn/"
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.layer.addSublayer(gradientLayer)
        
        locationManager.requestWhenInUseAuthorization()
        if(CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
    }
    //MARK: didUpdateLocations
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        self.lat = location.coordinate.latitude
        self.lon = location.coordinate.longitude
        
        let weather = WeatherApi()
        weather.updateWeatherOnPosition(lat: self.lat, lon: self.lon) { (result) in
            switch result {
            case .success(let WeatherData):
                DispatchQueue.main.async {
                    // Uppdatera UI
                    UIView.animate(withDuration: 0.5) {
                        self.cityLabel.text = "\(WeatherData.name)"
                        //make cool animation
                    }
                    self.degreeLabel.text = "\(WeatherData.main.temp)"
                    self.cityLabel.text = "\(WeatherData.name)"
                    self.conditionLabel.text = "\(WeatherData.weather[0].description)"
                    let iconName = "\(WeatherData.weather[0].icon)"
                    let icon2URL = self.iconURL + iconName + "@2x.png"
                    self.setImage(url: icon2URL)
                }
            case .failure(let error): print("Error: \(error)")
                }
        }
    }
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        // Kolla tiden och byt bakgrund baserat på tid
        setDarkblueGradientBackground()
        
    }
    // MARK: setBlueGradientBackground
    func setBlueGradientBackground(){
        let topColor = UIColor(red: 95.0/255.0, green: 165.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0, green: 114.0/255.0, blue: 184.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
    // MARK: setDarkBlueGradientBackground
    func setDarkblueGradientBackground(){
        let topColor = UIColor(red: 120.0/255.0, green: 150.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
    // MARK: setImage
    func setImage(url: String) {
        guard let imageURL = URL(string: url) else { return }

        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.weatherImage.image = image
            }
        }
    }
}
