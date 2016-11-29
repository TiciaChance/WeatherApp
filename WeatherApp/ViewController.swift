//
//  ViewController.swift
//  WeatherApp
//
//  Created by Laticia Chance on 11/27/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WeatherAPIDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cloudCoverLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var getCityWeatherButton: UIButton!
    
    // do my research into the deprecation of intializer pointers
    var weather : WeatherAPI? = nil
    let APIkey = "a758550619a710d385f31ca796ab2af1"
    let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    let city = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weather = WeatherAPI(delegate: self)
        
        
        self.cityLabel.text = weather?.city
        self.weatherLabel.text = weather?.weatherDescription
        self.temperatureLabel.text = "\(Int(round((weather?.tempFahrenheit)!)))°"
        self.cloudCoverLabel.text = ""
        self.windLabel.text = ""
        self.rainLabel.text = ""
        self.humidityLabel.text = ""
        self.cityTextField.placeholder = "Enter city name"
        self.cityTextField.delegate = self
        self.cityTextField.enablesReturnKeyAutomatically = true
        self.getCityWeatherButton.isEnabled = false
        
        //self.weather?.getWeatherByCity(city: self.cityTextField.text!)
        
        let weatherRequestURL = URL(string:"\(openWeatherMapBaseURL)?q=newyork&APPID=\(APIkey)")!
        let urlRequest = URLRequest(url: weatherRequestURL)
        
        
        weather?.APICall(urlRequest: urlRequest)
    }
    
    @IBAction func getWeatherForCityButtonTapped(sender: UIButton) {
        
        guard let text = cityTextField.text, !text.isEmpty else {
            print("nope")
            return
        }
        
        //if text.contains(" ") {
            let wordsFromSeparatedStr = text.components(separatedBy: " ")
            let combine = wordsFromSeparatedStr.joined()
        //}
        
        let BtnURL = URL(string:"\(openWeatherMapBaseURL)?q=\(combine)&APPID=\(APIkey)")!
        let btnUrlRequest = URLRequest(url: BtnURL)
        
        weather?.APICall(urlRequest: btnUrlRequest)
        updateLabels()
    }
    
    func updateLabels() {
        
        self.cityLabel.text = weather?.city
        self.weatherLabel.text = weather?.weatherDescription
        self.temperatureLabel.text = "\(Int(round((weather?.tempFahrenheit)!)))°"
        self.cloudCoverLabel.text = "\(weather?.cloudCover)%"
        self.windLabel.text = "\(weather?.windSpeed) m/s"
        self.humidityLabel.text = "\(weather?.humidity)%"
        
        
        
    }
    
    
    func didNotGetWeather(error: NSError) {
        // This method is called asynchronously, which means it won't execute in the main queue.
        // ALl UI code needs to execute in the main queue, which is why we're wrapping the call
        // to showSimpleAlert(title:message:) in a dispatch_async() call.
        DispatchQueue.main.async {
            self.showSimpleAlert(title: "Can't get the weather",
                                 message: "The weather service isn't responding.")
        }
        print("didNotGetWeather error: \(error)")
    }
    
    
    // MARK: - UITextFieldDelegate and related methods
    // -----------------------------------------------
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(
            in: range,
            with: string)
        
        getCityWeatherButton.isEnabled = prospectiveText.characters.count > 0
        print("Count: \(prospectiveText.characters.count)")
        return true
    }
    
    // Pressing the clear button on the text field (the x-in-a-circle button
    // on the right side of the field)
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // Even though pressing the clear button clears the text field,
        // this line is necessary. I'll explain in a later blog post.
        textField.text = ""
        
        getCityWeatherButton.isEnabled = false
        return true
    }
    
    // Pressing the return button on the keyboard should be like
    // pressing the "Get weather for the city above" button.
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        getWeatherForCityButtonTapped(sender: getCityWeatherButton)
        return true
    }
    
    // Tapping on the view should dismiss the keyboard.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    // MARK: - Utility methods
    // -----------------------
    
    func showSimpleAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style:  .default,
            handler: nil
        )
        alert.addAction(okAction)
        present(
            alert,
            animated: true,
            completion: nil
        )
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension String {
    
    var urlEncoded: String {
        
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlUserAllowed)!
        
    }
}






