//
//  CurrentWeather.swift
//  RainyWeather
//
//  Created by Steven Lattenhauer 2nd on 6/29/18.
//  Copyright © 2018 Steven Lattenhauer 2nd. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class CurrentWeather {
    
    var _location: String!
    var _date: String!
    var _weatherType: String!
    var _weatherImageName: String!
    
    // Even tho in the JSON, the temperatures and humidity are Doubles, I am changing them to strings since it will need to be passed into labels. Doign the conversion here as it is good practice to do all the data manipulation in the Model.
    var _currentTemp: String!
    var _highTemp: String!
    var _lowTemp: String!
    var _humidity: String!
    
    
    var location: String {
        if _location == nil {
            _location = ""
        }
        return _location
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var weatherImageName: String {
        if _weatherImageName == nil {
            _weatherImageName = ""
        }
        return _weatherImageName
    }
    
    var currentTemp: String {
        if _currentTemp == nil {
            _currentTemp = ""
        }
        return _currentTemp
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    var humidity: String {
        if _humidity == nil {
            _humidity = ""
        }
        return _humidity
    }
    
    func getWeather (completed: @escaping DownloadComplete) {
        //Alamofire download
        
        print(CURRENT_WEATHER_URL)

        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        Alamofire.request(currentWeatherURL).responseJSON {
            response in
//            print(response)
            
            if let dict = response.value as? Dictionary<String, Any> {
                
                if let name = dict["name"] as? String {
                    
                    self._location = name.capitalized
                    
                    if let sys = dict["sys"] as? Dictionary<String, Any> {
                        let countryName = sys["country"]
                        self._location = "\(name.capitalized)\(", ")\(countryName!)"
                    }
                    //                        print(self._location)
                }
                
                
                if let weather = dict["weather"] as? [Dictionary<String, Any>] {
                    
                    if let weatherCondition = weather[0]["main"] as? String {
                        self._weatherImageName = weatherCondition.capitalized
                        //                            print(self._weatherImageName)
                    }
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, Any>] {
                    
                    if let weatherCondition = weather[0]["description"] as? String {
                        self._weatherType = weatherCondition.capitalized
                        //                            print(self._weatherType)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, Any> {
                    
                    if let temperature = main["temp"] as? Double {
                        let convertFromKelvin = (temperature * (9/5)-459.67)
                        let farenheitResult = Int(round(10 * convertFromKelvin/10))
                        self._currentTemp = "\(farenheitResult)\("°")"
                        //                            print("Current Temp", self._currentTemp)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, Any> {
                    
                    if let highTemp = main["temp_max"] as? Double {
                        let convertFromKelvin = (highTemp * (9/5)-459.67)
                        let farenheitResult = Int(round(10 * convertFromKelvin/10))
                        self._highTemp = "\(farenheitResult)\("°")"
                        //                            print("High Temp", self._highTemp)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, Any> {
                    if let lowTemp = main["temp_min"] as? Double {
                        let convertFromKelvin = (lowTemp * (9/5)-459.67)
                        let farenheitResult = Int(round(10 * convertFromKelvin/10))
                        self._lowTemp = "\(farenheitResult)\("°")"
                        //                            print("Low Temp", self._lowTemp)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, Any> {
                    if let humidity = main["humidity"] as? Int {
                        self._humidity = "\(humidity)\("%")"
                    }
                }
            }
            completed()
        }
    }
}







