//
//  PlacesAPI.swift
//  WeatherApp
//
//  Created by Chirag N Shah on 17/11/19.
//  Copyright © 2019 Chirag N Shah. All rights reserved.
//

import Foundation
import Moya

struct PlacesAPI: TargetType {
    var sampleData: Data {
        return Data.init()
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    static let googleMapsAPIKey = "GOOGLE_MAPS_API_KEY"
    
    var placeSearchText: String
    
    var baseURL: URL {
        return URL.init(string: "https://maps.googleapis.com/")!
    }
    
    var method: Moya.Method {
        return Method.get
    }
    
    var path: String {
        return "maps/api/place/autocomplete/json"
    }
    
    var task: Task {
        return .requestParameters(parameters: ["input": placeSearchText,
                                               "types": "(cities)",
                                               "key": PlacesAPI.googleMapsAPIKey], encoding: URLEncoding.default)
    }
}
