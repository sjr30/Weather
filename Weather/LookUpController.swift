//
//  LookUpController.swift
//  Weather
//
//  Created by Sandhya Rao on 2/27/21.
//

import UIKit
import Foundation

class LookUpController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var lookUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        designLookupButton()
    }
    
    func designLookupButton() {
        lookUpButton.backgroundColor = .clear
        lookUpButton.layer.cornerRadius = 15
        lookUpButton.layer.borderWidth = 1
        lookUpButton.layer.borderColor = UIColor.gray.cgColor
    }

    func getWeather(_ trimmedCity: String) {
        APIRequests.getWeatherData(city: trimmedCity) { status, weather in
            if status == "error" {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: nil, message: "Please enter a valid city.", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: {Timer.scheduledTimer(withTimeInterval: 3, repeats:false, block: {_ in
                        self.dismiss(animated: true, completion: nil)
                    })})
                }
            } else {
                if let weather = weather {
                    print(status, weather)
                    DispatchQueue.main.async {
                        if let vc = self.storyboard?.instantiateViewController(identifier: "WeatherListController") as? WeatherListController {
                            vc.modalPresentationStyle = .fullScreen
                            vc.weather = weather
                            self.present(vc, animated: true, completion: nil)
                            
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func lookUpAction(_ sender: Any) {
        if let city = cityNameTextField.text {
            let trimmedCity = city.trimmingCharacters(in: .whitespaces)
            print(trimmedCity)
            if trimmedCity == "" {
                return
            }
            getWeather(trimmedCity)
        }
    }
    
    
    
}

