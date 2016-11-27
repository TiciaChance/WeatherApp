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
    var cityID = String()
    
    func APICall() {
        Alamofire.request("http://api.openweathermap.org/data/2.5/forecast/city?id=524901&APPID=a758550619a710d385f31ca796ab2af1").responseJSON { (response) in
        
            print(response.result.value)
        }
    }

}
