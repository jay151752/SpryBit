//
//  SecondViewController.swift
//  SprybitPractical
//
//  Created by ghervadaJay on 29/07/22.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var lattitudeLabel: UILabel!
    @IBOutlet weak var lonitudeLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var baseLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var degLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var timezoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    let viewModel = ServiceModel()
    var weatherViewModel: WeatherViewModel?
    
    var cityName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getWeatherdata()
    }
    
    @IBAction func onTapButtonBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    func getWeatherdata(){
        lattitudeLabel.text = "Latitude:\(weatherViewModel?.coord?.lat ?? 0.0)"
        lonitudeLabel.text = "LongiTude:\(weatherViewModel?.coord?.lon ?? 0.0)"
        mainLabel.text = "Main:\(weatherViewModel?.weather?.last?.main ?? "")"
        weatherDescriptionLabel.text = "WeatherDescription: \(weatherViewModel?.weather?.last?.weatherDescription ?? "")"
        idLabel.text = "Id:\(weatherViewModel?.weather?.last?.id ?? 0)"
        iconLabel.text = "Icon: \(weatherViewModel?.weather?.last?.icon ?? "")"
        baseLabel.text = "Base: \(weatherViewModel?.base ?? "")"
        tempLabel.text = "temperature in Celsius: \(String(format: "%.0f", weatherViewModel?.main?.temp ?? 0.0 - 273.15))"
        feelsLikeLabel.text = "FeelsLike: \(weatherViewModel?.main?.feelsLike ?? 0)"
        humidityLabel.text = "Humidity: \(weatherViewModel?.main?.humidity ?? 0)"
        visibilityLabel.text = "Visibility: \(weatherViewModel?.visibility ?? 0)"
        speedLabel.text = "Speed: \(weatherViewModel?.wind?.speed ?? 0.0)"
        degLabel.text = "Deg: \(weatherViewModel?.wind?.deg ?? 0)"
        sunriseLabel.text = "Sunrise: \(weatherViewModel?.sys?.sunrise ?? 0)"
        sunsetLabel.text = "Sunset: \(weatherViewModel?.sys?.sunset ?? 0)"
        timezoneLabel.text = "timezone: \(weatherViewModel?.timezone ?? 0)"
        countryLabel.text = "Country: \(weatherViewModel?.sys?.country ?? "")"
        nameLabel.text = "Name: \(weatherViewModel?.name ?? "")"
     }
}
