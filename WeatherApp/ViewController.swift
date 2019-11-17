//
//  ViewController.swift
//  WeatherApp
//
//  Created by Chirag N Shah on 17/11/19.
//  Copyright © 2019 Chirag N Shah. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController {
//    init() {
//        super.init(nibName: nil, bundle: nil)
//    }
    
    var mapView: MKMapView = {
        let mapView = MKMapView(frame: .zero)
        mapView.mapType = MKMapType.standard
        
        return mapView
    }()
    
    var viewModel = MainViewModel()
    
    let searchResultsController = SearchResultController.init(nibName: nil, bundle: nil)
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Weather App"
        
        searchController = UISearchController(searchResultsController: searchResultsController)
        
        self.navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(mapView)
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[mapView]-|", options: .alignAllCenterX, metrics: nil, views: ["mapView" : mapView]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[mapView]-|", options: .alignAllCenterY, metrics: nil, views: ["mapView" : mapView]))
        
        let latitude = CLLocationDegrees(exactly: 13.0827)!
        let longitude = CLLocationDegrees(exactly: 80.2707)!
        
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        mapView.setCenter(location, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
//        navigationItem.searchController?.isActive = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
//        viewModel.fetchWeather(for: City(name: "Chennai")).done { (weather) in
//            print("\(weather.temperature)")
//        }.cauterize()
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchResultsController.didSelectCity = { (city) in
            self.viewModel.fetchWeather(for: city).done({ (weather) in
                print("fetcher weather")
                
                self.searchController.isActive = false
                
                let cityannotation = MKPointAnnotation.init()
                
                cityannotation.title = city.name
                
                let latitude = CLLocationDegrees(exactly: 13.0827)!
                let longitude = CLLocationDegrees(exactly: 80.2707)!                
                let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                
                cityannotation.coordinate = location
                
                self.mapView.addAnnotation(cityannotation)
                
            }).cauterize()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        /// show viewcontroller..
        searchResultsController.search(with: searchText)
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        
        
    }
}
