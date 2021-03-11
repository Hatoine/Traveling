//
//  WeatherViewController.swift
//  TravelApp
//
//  Created by Antoine Antoniol on 18/10/2019.
//  Copyright © 2019 Antoine Antoniol. All rights reserved.
//

import UIKit
import CoreLocation

final class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    //  MARK: - Properties
    
    private let weatherService = WeatherService()
    private let weatherGpsService = GpsWeatherService()
    private let manager = CLLocationManager()
    private var long = Double()
    private var lat = Double()
    
    //  MARK: - Outlets
    
    @IBOutlet private weak var weatherLabel: UILabel!
    @IBOutlet weak var localizationButton: UIButton!
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private var cityLabel: UILabel!
    @IBOutlet private var cityTextField: UITextField!
    @IBOutlet private var tempLabel: UILabel!
    @IBOutlet var tempFeelLabel: UILabel!
    @IBOutlet var weatherDescriptionView: UIView!
    @IBOutlet var tempView: UIView!
    @IBOutlet var tempMinLabel: UILabel!
    @IBOutlet var tempMaxlabel: UILabel!
    @IBOutlet var windLabel: UILabel!
    @IBOutlet var windView: UIView!
    @IBOutlet var globalView: UIView!
    @IBOutlet var button: UIButton!
    
    
    
    //  MARK: - Actions

    func  setUpUi (tempLabel:UILabel,tempFeelLabel:UILabel,tempMinLabel:UILabel,tempMaxlabel:UILabel,weatherLabel:UILabel,weatherImageView:UIImageView,index:Int,weatherData:WeatherData){
        self.tempLabel.text = String(Int(weatherData.main.temp)) + " " + "°C"
        self.tempFeelLabel.text = "Res" + " " + String(Int(weatherData.main.feelsLike)) + " " + "°C"
        self.tempMinLabel.text = "Min" + " " + String(Int(weatherData.main.tempMin)) + " " + "°C"
        self.tempMaxlabel.text = "Max" + " " + String(Int(weatherData.main.tempMax)) + " " + "°C"
        self.weatherLabel.text = weatherData.weather[0].weatherDescription.uppercased()
        self.weatherImageView.image = UIImage(named: weatherData.weather[0].icon )
        self.windLabel.text = String(weatherData.wind.speed) + " " + "km/h"
    }
    
    @IBAction private func updateWeatherButton(_ sender: UIButton) {
        guard let city = cityTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        cityLabel.text = city
        weatherService.getWeatherDescription(city: city) { (success, weatherData) in
            DispatchQueue.main.async { 
                if success{
                    guard let weatherData = weatherData else { return }
                    self.setUpUi(tempLabel: self.tempLabel, tempFeelLabel: self.tempFeelLabel, tempMinLabel: self.tempMinLabel, tempMaxlabel: self.tempMaxlabel, weatherLabel: self.weatherLabel, weatherImageView: self.weatherImageView, index: 0, weatherData: weatherData)
                } else {
                    print("bad")
                }
            }
        }
    }
    
    @IBAction private func getCurrentLocationWeatherDescription(_ sender: UIButton) {
        weatherGpsService.getCurrentPositionWeatherDescription(longitude:long,latitude:lat,callBack:{(success, weatherData) in
            DispatchQueue.main.async {
                if success {
                    guard let weatherData = weatherData else { return }
                    self.cityLabel.text = weatherData.name
                    self.setUpUi(tempLabel: self.tempLabel, tempFeelLabel: self.tempFeelLabel, tempMinLabel: self.tempMinLabel, tempMaxlabel: self.tempMaxlabel, weatherLabel: self.weatherLabel, weatherImageView: self.weatherImageView, index: 0, weatherData: weatherData)
                } else {
                    self.showAlert(alert:.alertNetworkMessage)
                }
            }
        })
    }

    //  MARK: - Methods

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0]
        manager.stopUpdatingLocation()
        long = userLocation.coordinate.longitude
        lat = userLocation.coordinate.latitude
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error")
    }

    func determineMyCurrentLocation() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()
        }
    }
    
    
    //  MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getCurrentLocationWeatherDescription(localizationButton)
        viewShadow(view: weatherDescriptionView, cornerRadius: 25)
        viewShadow(view: tempView, cornerRadius: 25)
        viewShadow(view: windView, cornerRadius: 25)
        viewShadow(view: globalView, cornerRadius: 25)
        setUpButton(button: button)
        setUpLabel(label: cityLabel)
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        determineMyCurrentLocation()
    }
}
