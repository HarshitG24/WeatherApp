//
//  ViewController.swift
//  My_Weather_App
//
//  Created by Harshit Gajjar on 10/11/19.
//  Copyright © 2019 ThinkX. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherVC: UIViewController {
    


    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var minTempLbl: UILabel!
    @IBOutlet weak var maxTempLbl: UILabel!
    @IBOutlet weak var pressureLbl: UILabel!
    
    
    let locationManager = CLLocationManager()
    let weather = Weather()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    


}

extension WeatherVC: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let updatedLocation = locations[locations.count - 1]
        
        if updatedLocation.horizontalAccuracy > 0{
            locationManager.stopUpdatingLocation()
            fetchWeather(lat: updatedLocation.coordinate.latitude, lon: updatedLocation.coordinate.longitude)
        }else{
            cityLbl.text = "Unavailable.."
        }
    }
    
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees){
        
        Alamofire.request("https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(appid)").responseJSON{
            response in
            
            if response.result.isSuccess{
                
                let json: JSON = JSON(response.result.value!)
                print(json)
                self.updateWeatherClass(json: json)
            }else{
                print("Inavlid!!!")
            }
        }
    }
    
    func updateWeatherClass(json: JSON){
        
        if let temp = json["main"]["temp"].double{
            weather.cityName = "\(json["name"]), \(json["sys"]["country"])"
            weather.temperature = "\(Int(temp - 273.15)) °C"
            weather.maxtemp = "\(Int(json["main"]["temp_max"].double! - 273.15)) °C"
            weather.mintemp = "\(Int(json["main"]["temp_min"].double! - 273.15)) °C"
            weather.description = "\(json["weather"][0]["description"])"
            weather.pressure = "\(json["main"]["pressure"]) hPa"
            weather.weatherImage = weather.weatherImageId(id: json["weather"][0]["id"].intValue)
            updateUI()
        }
    }
    
    func updateUI(){
        cityLbl.text = weather.cityName
        tempLbl.text = weather.temperature
        maxTempLbl.text = weather.maxtemp
        minTempLbl.text = weather.mintemp
        pressureLbl.text = weather.pressure
        descriptionLbl.text = weather.description
        weatherImg.image = UIImage(named: weather.weatherImage)
    }
    
}
