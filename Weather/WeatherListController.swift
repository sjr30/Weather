//
//  WeatherListController.swift
//  Weather
//
//  Created by Sandhya Rao on 2/28/21.
//

import UIKit

class WeatherListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var backButton: UIBarButtonItem!
    var weather: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(weather!)
        tableView.delegate = self
        if let weather = weather {
            cityName.text = weather.city
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let weather = weather {
            return weather.weatherDetails.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        if let weather = weather {
            let weatherDetail = weather.weatherDetails[indexPath.row]
            if weatherDetail.weather == "Clouds" {
                cell.label?.text = "Cloudy"
            } else {
                cell.label?.text = weatherDetail.weather
            }
            cell.temp?.text = "Temp: " + String(weatherDetail.temperature)
            return cell
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController, let weather = self.weather {
            vc.modalPresentationStyle = .fullScreen
            vc.weatherDetail = self.weather?.weatherDetails[indexPath.row]
            vc.city = weather.city
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        print("Back Button Clicked")
        self.dismiss(animated: true, completion: nil)
    }
}
