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

class WeatherAPI: NSObject {
    
    let APIkey = "a758550619a710d385f31ca796ab2af1"
    var city = "newyork"
    
    func APICall() {
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=\(APIkey)").responseJSON { (response) in
            
            guard let weather = JSON(data: response.data!).dictionary else {return}
                
            print("Date and time: \(weather["dt"]!)")
            print("City: \(weather["name"]!)")
            
            print("Longitude: \(weather["coord"]?["lon"])")
            print("Latitude: \(weather["coord"]?["lat"])")
            
            print("Weather ID: \(weather["weather"]![0]["id"])")
            print("Weather main: \(weather["weather"]![0]["main"])")
            print("Weather description: \(weather["weather"]![0]["description"])")
            print("Weather icon ID: \(weather["weather"]![0]["icon"])")
            
            print("Temperature: \(weather["main"]!["temp"])")
            print("Humidity: \(weather["main"]!["humidity"])")
            print("Pressure: \(weather["main"]!["pressure"])")
            
            print("Cloud cover: \(weather["clouds"]!["all"])")
            
            print("Wind direction: \(weather["wind"]!["deg"]) degrees")
            print("Wind speed: \(weather["wind"]!["speed"])")
            
            print("Country: \(weather["sys"]!["country"])")
            print("Sunrise: \(weather["sys"]!["sunrise"])")
            print("Sunset: \(weather["sys"]!["sunset"])")        }
    }

}
