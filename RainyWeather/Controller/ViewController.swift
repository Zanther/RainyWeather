//
//  ViewController.swift
//  RainyWeather
//
//  Created by Steven Lattenhauer 2nd on 6/28/18.
//  Copyright © 2018 Steven Lattenhauer 2nd. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherConditionLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var humidityPercentage: UILabel!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecastArr = [Forecast]()
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    static var cellIdentifier: String = "weatherCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        currentWeather = CurrentWeather ()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()

    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()

            currentLocation = locationManager.location
    
            print(currentLocation.coordinate.latitude)
            print(currentLocation.coordinate.longitude)
            
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            currentWeather.getWeather{
                self.locationManager.stopUpdatingLocation()
                self.updateMainUI()
                
                self.getWeatherForcast{
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    
    func getWeatherForcast(completed: @escaping DownloadComplete) {
        
        print(FORECAST_WEATHER_URL)
        
        let forecastWeatherURL = URL(string: FORECAST_WEATHER_URL)!
        
        Alamofire.request(forecastWeatherURL).responseJSON { response in
            
//            print("Weather API:", response)
            
            if let dict = response.value as? Dictionary<String, Any> {
                
                if let list = dict["list"] as? [Dictionary<String, Any>] {
                    
                    for obj in list {
                        
                        let forecast = Forecast(weatherDict: obj)
                        self.forecastArr.append(forecast)
                    }
                    self.forecastArr.remove(at: 0)
                }
                self.tableView.reloadData()
            }
            completed()
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? ForecastCell {
            let forecastCellData = self.forecastArr[indexPath.row]
            cell.configureCell(forecast: forecastCellData)

            return cell
        } else {
            return ForecastCell()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastArr.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let tableHeaderTitle = "\(forecastArr.count)\("-Day Forecast")"
        
        return tableHeaderTitle
    }
    
    func updateMainUI() {
        
        dateLbl.text = currentWeather.date
        locationLbl.text = currentWeather.location
        weatherImage.image = UIImage(named: currentWeather.weatherImageName)
        weatherConditionLbl.text = currentWeather.weatherType
        temperatureLbl.text = "\(currentWeather.currentTemp)"
        humidityPercentage.text = "\(currentWeather.humidity)"
        
//        print("Date:", currentWeather.date)
//        print("Location:", currentWeather.location)
//        print("Weather Image Name:", currentWeather.weatherImageName)
//        print("Weather Type", currentWeather.weatherType)
//        print("Current Weather Temp", currentWeather.currentTemp)
//        print("Current Humidity", currentWeather.humidity)
//        print("High Temperature:", currentWeather.highTemp)
//        print("Low Temperature:", currentWeather.lowTemp)
        
    }
    
    
}

