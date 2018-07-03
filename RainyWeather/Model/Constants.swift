//
//  Constants.swift
//  RainyWeather
//
//  Created by Steven Lattenhauer 2nd on 6/29/18.
//  Copyright © 2018 Steven Lattenhauer 2nd. All rights reserved.
//

import Foundation

let BASE_URL = "https://api.openweathermap.org/data/2.5/weather?"
let FORECAST_BASE_URL = "https://api.openweathermap.org/data/2.5/forecast/daily?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let FORECAST_DAYS_COUNT = "&cnt="
let APP_ID = "&appid="
let API_KEY = "0d1a007e53a7aebcdf407e5d8e3f012a"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID)\(API_KEY)"

let FORECAST_WEATHER_URL = "\(FORECAST_BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(FORECAST_DAYS_COUNT)15\(APP_ID)\(API_KEY)"

