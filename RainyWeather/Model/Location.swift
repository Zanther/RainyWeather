//
//  Location.swift
//  RainyWeather
//
//  Created by Steven Lattenhauer 2nd on 7/3/18.
//  Copyright © 2018 Steven Lattenhauer 2nd. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init(){}
    
    var latitude: Double!
    var longitude: Double!
    
}
