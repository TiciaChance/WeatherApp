//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Laticia Chance on 11/27/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol WeatherAPIDelegate {
    
    func didGetWeather(weather: Weather)
    func didNotGetWeather(error: NSError)
}

class WeatherAPI: NSObject {
    
    let APIkey = "a758550619a710d385f31ca796ab2af1"
    var city = "newyork"
    var weatherDictionary = [String : Any]()
    
    func APICall() {
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=\(APIkey)").responseJSON { (response) in
            
            guard let weather = JSON(data: response.data!).dictionary else {return}
            
            guard let main = weather["main"] else {return}
            
            self.weatherDictionary["Date and time"] = weather["dt"]
            self.weatherDictionary["City"] = weather["name"]
            
            self.weatherDictionary["Longitude"] = weather["coord"]?["lon"]
            self.weatherDictionary["Latitude"] = weather["coord"]?["lat"]
            
            self.weatherDictionary["Weather ID"] = weather["weather"]![0]["id"]
            self.weatherDictionary["Weather main"] = weather["weather"]![0]["main"]
            self.weatherDictionary["Weather description"] = weather["weather"]![0]["description"]
            self.weatherDictionary["Weather icon ID"] = weather["weather"]![0]["icon"]
            
            self.weatherDictionary["Temperature"] = main["temp"].stringValue
           self.weatherDictionary["Humidity"] = main["temp"].stringValue
           self.weatherDictionary["Pressure"] =  main["pressure"].stringValue
            
            self.weatherDictionary["Cloud cover"] = weather["clouds"]!["all"]
            self.weatherDictionary["Wind direction"] = weather["wind"]!["deg"]
            self.weatherDictionary["Wind speed"] = weather["wind"]!["speed"]

            self.weatherDictionary["Country"] = weather["sys"]!["country"]
            self.weatherDictionary["Sunrise"] = weather["sys"]!["sunrise"]
            self.weatherDictionary["Sunset"] = weather["sys"]!["sunset"]
            
            print(weather["weather"]?[0])
           // print(weather)

        }
    }
    
}


