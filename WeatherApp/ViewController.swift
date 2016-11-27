//
//  ViewController.swift
//  WeatherApp
//
//  Created by Laticia Chance on 11/27/16.
//  Copyright © 2016 Laticia Chance. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var weather = WeatherAPI()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        weather.APICall()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

