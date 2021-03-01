//
//  APIRequests.swift
//  Weather
//
//  Created by Sandhya Rao on 2/27/21.
//
//This class contains code to build URL using URLComponents to make api call, get the weather data and parse it.

import Foundation
import UIKit

class APIRequests {
    
    class func getWeatherData(city: String, completion: @escaping (String, Weather?) -> Void) {
        if let url = self.getURL(city: city) {
            print(url)
            //let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&units=imperial&appid=65d00499677e59496ca2f318eb68c049")
          
            let request = URLRequest(url: url)
            let dataTask = URLSession.shared.dataTask(with: request) {(data, response, error) in
                if error != nil {
                    print(error?.localizedDescription)
                    completion("error", nil)
                    return
                }
                if let data = data {
                    let backToString = String(data: data, encoding: String.Encoding.utf8)
                    print("data: \(String(describing: backToString))")
                    let weatherDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                    if let weatherDic = weatherDictionary {
                        parseWeatherData(dic: weatherDic, completion: completion)
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    class func parseWeatherData(dic: [String: Any], completion: @escaping (String, Weather?) -> Void) {
        var cityName = ""
        var weatherDetails = [WeatherDetail]()
        if let message = dic["message"] as? String, message == "city not found" {
            completion("error", nil)
            return
        }
        if let city = dic["city"] as? [String: Any], let name: String = city["name"] as? String, let country = city["country"] as? String  {
            cityName = name + ", " + country
            print(cityName)
        }
        if let list = dic["list"] as? [[String: Any]] {
            for item in list {
                if let main = item["main"] as? [String: Any], let weather = item["weather"] as? [[String: Any]], let temperature = main["temp"] as? Double, let feelsLike = main["feels_like"] as? Double, let mainWeather = weather[0]["main"] as? String, let weatherDescription = weather[0]["description"] as? String {
                    let weatherDetail = WeatherDetail(temperature: Int(temperature), feelsLike: Int(feelsLike), weather: mainWeather, weatherDescription: weatherDescription)
                    weatherDetails.append(weatherDetail)
                }
            }
        }
        let weather = Weather(city: cityName, weatherDetails: weatherDetails)
        completion("success", weather)
    }
    
    
    //This function builds url with safe ASCII characters.
    class func getURL(city: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/forecast"
        components.queryItems = [URLQueryItem]()
        let queryItem1 = URLQueryItem(name: "q", value: city)
        let queryItem2 = URLQueryItem(name: "units", value: "imperial")
        let queryItem3 = URLQueryItem(name: "appid", value: "65d00499677e59496ca2f318eb68c049")
        components.queryItems?.append(queryItem1)
        components.queryItems?.append(queryItem2)
        components.queryItems?.append(queryItem3)
        return components.url
    }
}
