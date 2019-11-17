//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Chirag N Shah on 17/11/19.
//  Copyright © 2019 Chirag N Shah. All rights reserved.
//

import Foundation
import UIKit

class SearchResultController: UITableViewController {
    
    var didSelectCity: ((City) -> Void)? = nil
    
    var viewModel = SearchResultViewModel()
    var fetchedCities: [City] = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesSearchBarWhenScrolling = false
        
//        self.view.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        
        self.tableView.tableFooterView = UIView.init()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return (fetchedCities.count > 0 ? 1 : 0)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.self), for: indexPath)
        
        let fetchedCity = fetchedCities[indexPath.row]
        tableViewCell.textLabel?.text = fetchedCity.name
        
        return tableViewCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /// delegate did select city..
        guard let didSelectCity = didSelectCity else {
            return
        }
        
        let selectedCity = fetchedCities[indexPath.row]
        
        didSelectCity(selectedCity)
    }
    
    public func search(with searchText: String) {
        viewModel.fetchCities(for: searchText).done { (cities) in
            
            self.fetchedCities = cities
            self.tableView.reloadData()
            print(cities.count)
        }.cauterize()
    }
}
