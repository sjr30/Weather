//
//  WeatherData.swift
//  Weather
//
//  Created by Sandhya Rao on 2/27/21.
//

import Foundation

struct Weather {
    let city: String
    let weatherDetails: [WeatherDetail]
}
 
struct WeatherDetail {
    let temperature: Int
    let feelsLike: Int
    let weather: String
    let weatherDescription: String
}
