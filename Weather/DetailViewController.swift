//
//  DetailViewController.swift
//  Weather
//
//  Created by Sandhya Rao on 3/1/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var weatherDetail: WeatherDetail?
    var city: String?

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let weatherDetail = weatherDetail, let city = city {
            cityName.text = city
            tempLabel.text = String(weatherDetail.temperature)
            feelsLikeLabel.text = "Feels Like: " + String(weatherDetail.feelsLike)
            weatherLabel.text = weatherDetail.weather
            descriptionLabel.text = weatherDetail.weatherDescription
        }
    }
    

    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
