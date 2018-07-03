//
//  Forecast.swift
//  RainyWeather
//
//  Created by Steven Lattenhauer 2nd on 7/2/18.
//  Copyright © 2018 Steven Lattenhauer 2nd. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

class Forecast {
    
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    var _weatherImageName: String!
    var _forecasts = [Forecast]()
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }

    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
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
    
    var weatherImageName: String {
        if _weatherImageName == nil {
            _weatherImageName = ""
        }
        return _weatherImageName
    }
    
    init(weatherDict: Dictionary<String, Any>) {

        if let temp = weatherDict["temp"] as? Dictionary<String, Any> {

            if let min = temp["min"] as? Double {

                    let convertFromKelvin = (min * (9/5)-459.67)
                    let farenheitResult = Int(round(10 * convertFromKelvin/10))
                    self._lowTemp = "\(farenheitResult)\("°")"
//                print("Low Temp:", self._lowTemp)
            }

            if let max = temp["max"] as? Double {

                let convertFromKelvin = (max * (9/5)-459.67)
                let farenheitResult = Int(round(10 * convertFromKelvin/10))
                self._highTemp = "\(farenheitResult)\("°")"
//                print("High Temp:", self._highTemp)
            }
        }

        if let weather = weatherDict["weather"] as? [Dictionary<String, Any>] {

            if let weatherCondition = weather[0]["description"] as? String {

                self._weatherType = weatherCondition
//                print("Weather Type:", self._weatherType)
            }

            if let weatherConditionShort = weather[0]["main"] as? String {

                self._weatherImageName = weatherConditionShort
            }

        }

        if let date = weatherDict["dt"] as? Double {

            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .none
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.dateStyle = .full
            self._date = unixConvertedDate.dayOfTheWeak()
//            print("Forecast Date:", self._date)
        }

    }

}

extension Date {
    func dayOfTheWeak() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
