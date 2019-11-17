//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Chirag N Shah on 17/11/19.
//  Copyright © 2019 Chirag N Shah. All rights reserved.
//

import Foundation
import PromiseKit
import Moya

protocol IMainViewModel {
    
}

class MainViewModel {

    var networkService = MoyaProvider<WeatherAPI>.init()
    var placesAPIService = MoyaProvider<WeatherAPI>.init()
    
    func fetchWeather(for city: City) -> Promise<Weather> {
     
        /// make APIvie
        return Promise(resolver: { (seal) in
            networkService.request(WeatherAPI(apiType: .cityName(name: city.name))) { (result) in
                let weather = Weather(temperature: "")
                
                switch result {
                case .success(let value):
                    let responseString = String(data: value.data, encoding: .utf8)
                    print("response String: \(responseString)")
                    seal.fulfill(weather)
                    break
                case .failure(let error):
                    seal.reject(AppError(description: "WeatherAPI error."))
                    break
                }
            }
        })
    }
    
    func fetchLocation(for city: City) -> Promise<(String, String)> {
        
        /// make APIvie
        return Promise(resolver: { (seal) in
            seal.fulfill(("",""))
        })
    }
}
