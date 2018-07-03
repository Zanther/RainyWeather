//
//  ForecastCell.swift
//  RainyWeather
//
//  Created by Steven Lattenhauer 2nd on 7/2/18.
//  Copyright © 2018 Steven Lattenhauer 2nd. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {

    
    @IBOutlet weak var forecastCellImage: UIImageView!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var weatherTypeLbl: UILabel!
    @IBOutlet weak var highTempLbl: UILabel!
    @IBOutlet weak var lowTempLbl: UILabel!
    
    func configureCell(forecast: Forecast) {
        
        forecastCellImage.image = UIImage(named: forecast.weatherImageName)
        dayLbl.text = forecast.date
        weatherTypeLbl.text = forecast.weatherType
        highTempLbl.text = forecast.highTemp
        lowTempLbl.text = forecast.lowTemp
    }


}
