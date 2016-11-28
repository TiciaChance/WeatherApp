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

class WeatherAPI {
    
    let APIkey = "a758550619a710d385f31ca796ab2af1"
    let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    
    var city = String()
    var weatherDictionary = [String : Any]()
    
    private var delegate: WeatherAPIDelegate

    init(delegate: WeatherAPIDelegate) {
        self.delegate = delegate
    }


    func getWeatherByCity(city: String) {
        let weatherRequestURL = NSURL(string: "\(openWeatherMapBaseURL)?q=\(city)&APPID=\(APIkey)")!
        APICall(weatherRequestURL: weatherRequestURL)
    }
    
    func APICall(weatherRequestURL: NSURL) {
        
        
        Alamofire.request(weatherRequestURL as! URLRequestConvertible).responseJSON { (response) in
            
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

//    func getWeatherByCity(city: String) {
//
//        let weatherRequestURL = NSURL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapBaseURL)&q=\(city)")!
//        APICall(weatherRequestURL: weatherRequestURL)
//    }
//
////     func APICall(weatherRequestURL: NSURL) {
////
////        // This is a pretty simple networking task, so the shared session will do.
////        let session = URLSession.shared
////
////
////        let dataTask = session.dataTask(with: weatherRequestURL) {
////            if let networkError = error {
////                // Case 1: Error
////                // An error occurred while trying to get data from the server.
////                self.delegate.didNotGetWeather(networkError)
////            }
////
////            else {
////                // Case 2: Success
////                // We got data from the server!
////                do {
////                    // Try to convert that data into a Swift dictionary
////                    let weatherData = try NSJSONSerialization.JSONObjectWithData(
////                        data!,
////                        options: .MutableContainers) as! [String: AnyObject]
////
////                    // If we made it to this point, we've successfully converted the
////                    // JSON-formatted weather data into a Swift dictionary.
////                    // Let's now used that dictionary to initialize a Weather struct.
////                    let weather = Weather(weatherData: weatherData)
////
////                    // Now that we have the Weather struct, let's notify the view controller,
////                    // which will use it to display the weather to the user.
////                    self.delegate.didGetWeather(weather)
////                }
////                catch let jsonError as NSError {
////                    // An error occurred while trying to convert the data into a Swift dictionary.
////                    self.delegate.didNotGetWeather(jsonError)
////                }
////            }
////        }
////
////        // The data task is set up...launch it!
////        dataTask.resume()
////    }
////
////}

