//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Chirag N Shah on 17/11/19.
//  Copyright © 2019 Chirag N Shah. All rights reserved.
//

import Foundation
import Moya

enum WeatherAPIType {
    case cityName(name: String)
    case cityID(ID: String)
}

struct WeatherAPI: TargetType {
    
    static let APIKEY = "OPEN_WEATHER_API_KEY"

    
    var apiType: WeatherAPIType
    
    var baseURL: URL {
        return URL(string: "https://api.openweathermap.org")!
    }
    
    var path: String {
        return "data/2.5/weather"
    }
    
    var method: Moya.Method {
        return Method.get
    }
    
    var sampleData: Data {
        return Data.init()
    }
    
    var task: Task {
        
        var parameters = [String: Any]()
        
        switch apiType {
        case let .cityName(name):
            parameters["q"] = name
            break
        case let .cityID(_):
            break
        }
        
        parameters["APPID"] = WeatherAPI.APIKEY
        
        return Task.requestParameters(parameters: parameters,
                                      encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
}
