//
//  SearchResultViewModel.swift
//  WeatherApp
//
//  Created by Chirag N Shah on 17/11/19.
//  Copyright © 2019 Chirag N Shah. All rights reserved.
//

import Foundation
import PromiseKit
import Moya
import SwiftyJSON

class SearchResultViewModel {
    
    var networkService = MoyaProvider<PlacesAPI>.init()
    
    func fetchCities(for text: String) -> Promise<[City]> {
        return Promise.init(resolver: { (seal) in
            networkService.request(PlacesAPI(placeSearchText: text)) { (result) in
                
                switch result {
                case .success(let response):
                    do {
                        guard let jsonResponse = try JSON(data: response.data).dictionary,
                            let predictions = jsonResponse["predictions"]?.arrayObject as? [[String: Any]] else {
                                
                                seal.reject(AppError(description: ""))
                                return
                        }
                        
                        let cities = predictions.compactMap({ (predictedCity) -> City? in
                            guard let cityName = predictedCity["description"] as? String,
                                let placeID = predictedCity["place_id"] as? String else {
                                return nil
                            }
                            
                            return City(name: cityName.components(separatedBy: ",").first!, placeID: placeID)
                        })
                        
                        seal.fulfill(cities)
                    } catch {
                        seal.reject(error)
                    }
                    break
                case .failure(let error):
                    seal.reject(error)
                    break
                }
            }
        })
    }
}

