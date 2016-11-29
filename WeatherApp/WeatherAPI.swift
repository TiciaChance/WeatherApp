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
    
    //func didGetWeather(weather: Weather)
    func didNotGetWeather(error: NSError)
}

class WeatherAPI {
    
    let APIkey = "a758550619a710d385f31ca796ab2af1"
    let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    
    var city = String()
    var country = String()
    var longitude = Double()
    var latitude = Double()
    
    var weatherID = Int()
    var mainWeather = String()
    var weatherDescription = String()
    var weatherIconID = String()
    
    var dateAndTime = NSDate()
    
    
    // OpenWeatherMap reports temperature in Kelvin, so...
    
    var temp = Double()
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
    
    var humidity = Int()
    var pressure = Int()
    var cloudCover = Int()
    var windSpeed = Double()
    
    var windDirection = Double()
    //let rainfallInLast3Hours: Double?
    
    var sunrise = NSDate()
    var sunset = NSDate()
    
    
    var weatherDictionary = [String : Any]()
    
    private var delegate: WeatherAPIDelegate
    
    init(delegate: WeatherAPIDelegate) {
        self.delegate = delegate
    }
    
    
    func getWeatherByCity(city: String) {
        let weatherRequestURL = URL(string: "\(openWeatherMapBaseURL)?q=\(city)&APPID=\(APIkey)")!
        let urlRequest = URLRequest(url: weatherRequestURL)
        
        APICall(urlRequest: urlRequest)
    }
    
    
    
    func APICall(urlRequest: URLRequest) {
        
        Alamofire.request(urlRequest).responseJSON { (response) in
            
            guard let weather = JSON(data: response.data!).dictionary else {return}
            
            guard let main = weather["main"] else {return}
            
            self.weatherDictionary["Date and Time"] = weather["dt"]
            self.city = (weather["name"]?.stringValue)!
            
            self.longitude = (weather["coord"]?["lon"].doubleValue)!
            self.latitude = (weather["coord"]?["lat"].doubleValue)!
            
            self.weatherID = weather["weather"]![0]["id"].intValue
            self.mainWeather = weather["weather"]![0]["main"].stringValue
            self.weatherDescription = weather["weather"]![0]["description"].stringValue
            self.weatherIconID = weather["weather"]![0]["icon"].stringValue
            
            self.temp = main["temp"].doubleValue
            self.humidity = main["temp"].intValue
            self.pressure =  main["pressure"].intValue
            
            self.cloudCover = weather["clouds"]!["all"].intValue
            self.windDirection = weather["wind"]!["deg"].doubleValue
            self.windSpeed = weather["wind"]!["speed"].doubleValue
            
            self.country = weather["sys"]!["country"].stringValue
            self.sunrise = NSDate(timeIntervalSince1970: weather["sys"]!["sunrise"].doubleValue)
            self.sunset = NSDate(timeIntervalSince1970: weather["sys"]!["sunset"].doubleValue)
            
            
            print(self.city)
            // print(weather)
            
        }
        
        
    }
}



//    func APICall(urlRequest: URLRequest) {
//
//        let session = URLSession.shared
//
//        let task = session.dataTask(with: urlRequest) {
//            (data, response, error) in
//            if let networkError = error {
//                // Case 1: Error
//                // An error occurred while trying to get data from the server.
//                self.delegate.didNotGetWeather(error: networkError as NSError)
//            }
//
//            else {
//                // Case 2: Success
//                // We got data from the server!
//                do {
//                    // Try to convert that data into a Swift dictionary
//                    let weatherData = try JSONSerialization.jsonObject(
//                        with: data!,
//                        options: .mutableContainers) as! [String: AnyObject]
//
//                    // If we made it to this point, we've successfully converted the
//                    // JSON-formatted weather data into a Swift dictionary.
//                    // Let's now used that dictionary to initialize a Weather struct.
//                    let weather = Weather(weatherData: weatherData)
//
//                    // Now that we have the Weather struct, let's notify the view controller,
//                    // which will use it to display the weather to the user.
//                    self.delegate.didGetWeather(weather: weather)
//                }
//                catch let jsonError as NSError {
//                    // An error occurred while trying to convert the data into a Swift dictionary.
//                    self.delegate.didNotGetWeather(error: jsonError)
//                }
//            }
//        }
//
//        // The data task is set up...launch it!
//        task.resume()
//    }
//
//}
