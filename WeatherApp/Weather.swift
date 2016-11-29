//
//  Weather.swift
//  WeatherApp
//
//  Created by Laticia Chance on 11/28/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Weather {
    
    let dateAndTime: NSDate
    
    let city: String
    let country: String
    let longitude: Double
    let latitude: Double
    
    let weatherID: Int
    let mainWeather: String
    let weatherDescription: String
    let weatherIconID: String
    
    // OpenWeatherMap reports temperature in Kelvin, so...
    
    private let temp: Double
    var tempCelsius: Double {
        get {
            return temp - 273.15
        }
    }
    
    var tempFahrenheit: Double {
        get {
            return (temp - 273.15) * 1.8 + 32
        }
    }
    let humidity: Int
    let pressure: Int
    let cloudCover: Int
    let windSpeed: Double
    
    // These properties are optionals because OpenWeatherMap doesn't provide:
    // - a value for wind direction when the wind speed is negligible
    // - rain info when there is no rainfall
    let windDirection: Double?
    let rainfallInLast3Hours: Double?
    
    let sunrise: NSDate
    let sunset: NSDate

    var newDict = [String: Any]()
    
    init(weatherData: [String: AnyObject], weather: WeatherAPI) {
        
        newDict = weather.weatherDictionary
        
        dateAndTime = NSDate(timeIntervalSince1970: newDict["Date and Time"] as! TimeInterval)
        city = newDict["City Name"] as! String
        
        longitude = newDict["Longitude"] as! Double
        latitude = newDict["Latitude"] as! Double
        
        weatherID = newDict["Weather ID"] as! Int
        mainWeather = newDict["Weather main"] as! String
        weatherDescription = newDict["Weather description"] as! String
        weatherIconID = newDict["Weather icon ID"] as! String
        
        temp = newDict["Temperature"] as! Double
        humidity = newDict["Humidity"] as! Int
        pressure = newDict["Pressure"] as! Int
  
        cloudCover = newDict["Cloud Cover"] as! Int
        windSpeed = newDict["Wind speed"] as! Double
        windDirection = newDict["Wind direction"] as! Double?
        
        country = newDict["Country"] as! String
        
        
        if newDict["rain"] != nil {
            let rainDict = newDict["rain"] as! [String: AnyObject]
            rainfallInLast3Hours = rainDict["3h"] as? Double
        }
        else {
            rainfallInLast3Hours = nil
        }
        
        sunrise = NSDate(timeIntervalSince1970: newDict["Sunrise"] as! TimeInterval)
        sunset = NSDate(timeIntervalSince1970: newDict["Sunset"] as! TimeInterval)
    }
    
}
