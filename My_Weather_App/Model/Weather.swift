//
//  Weather.swift
//  My_Weather_App
//
//  Created by Harshit Gajjar on 10/11/19.
//  Copyright © 2019 ThinkX. All rights reserved.
//

import Foundation


class Weather{
    public var temperature: String = ""
    public var cityName: String = ""
    public var description: String = ""
    public var maxtemp: String = ""
    public var mintemp: String = ""
    public var weatherImage: String = ""
    public var pressure: String = ""
    
    func weatherImageId(id: Int) ->String{
        switch id {
        case 200...232:
            return "1"
            
        case 300...321:
            return "2"
            
        case 500...531:
            return "3"
            
        case 600...622:
            return "4"
            
        case 701...781:
            return "5"
            
        case 800:
            return "7"
            
        case 801...804:
            return "8"
        default:
            return ""
        }
    }
}
