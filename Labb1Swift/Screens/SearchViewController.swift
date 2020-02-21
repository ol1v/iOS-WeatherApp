//
//  SearchViewController.swift
//  Labb1Swift
//
//  Created by Oliver Lennartsson on 2020-02-18.
//  Copyright © 2020 Oliver Lennartsson. All rights reserved.
//
// MARK: TODO

// Fixa AlertController så att man kan lägga till i favoriter
// Fixa "FavoritesController"
// Fixa CustomCell till FavoritesController
// Fixa så att man kan jämföra väder på två olika ställen (favorit + sök och jämför med valfri stad)
// Fixa notiser om klädväl efter väder

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController!
    var originalDataSource: [String] = []
    var updatedDataSource: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cities: [Name] = getCityName()
        let testString: String = cities[0].name
        
        print("cities index0.citiesArray0.name \(testString)")
        
        for city in cities {
            originalDataSource.append(city.name)
        }

        tableView.delegate = self
        tableView.dataSource = self
        
        updatedDataSource = originalDataSource
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        //searchController.obscuresBackgroundDuringPresentation = false
        searchView.addSubview(searchController.searchBar)
        searchController.searchBar.delegate = self
        
    }
    // TA BORT
    func addObjectToDataSource(dataSourceCount: Int, dataSourceObject: String) {
        
        for index in 1...dataSourceCount {
            originalDataSource.append("\(dataSourceObject) index\(index)")
        }
    }
    func filterUpdatedDataSource(searchWord: String) {
        if searchWord.count > 0 {
            updatedDataSource = originalDataSource
            
            let filteredResults = updatedDataSource.filter { $0.replacingOccurrences(of: " ", with: "").lowercased().contains(searchWord.replacingOccurrences(of: " ", with: "").lowercased()) }
            
            updatedDataSource = filteredResults
            tableView.reloadData()
        }
    }
    func restoreUpdatedData() {
        updatedDataSource = originalDataSource
    }
    // Flytta funktion till Weather eller CityNames
    func getCityName() -> [Name] {
        let fileName: String = "city.list"
        
        do {
            
            if let file = Bundle.main.url(forResource: fileName, withExtension: "json") {
                let data = try Data.init(contentsOf: file)
                
                let decoder = JSONDecoder()
                
                let cityList: [Name] = try decoder.decode([Name].self, from: data)
                
                return cityList
            }
        } catch {
            print("Couldn't decode city.list.json")
        }
        return [Name]()
    }
    
}
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchWord = searchController.searchBar.text {
            filterUpdatedDataSource(searchWord: searchWord)
        }
    }
}
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        
        if let searchWord = searchBar.text {
            filterUpdatedDataSource(searchWord: searchWord)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        
        if let searchWord = searchBar.text, !searchWord.isEmpty {
            restoreUpdatedData()
        }
    }

}
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Gör webrequest
        var city: String = ""
        var temp: Double = 0
        
        let weather = WeatherApi()
        weather.updateWeather(lat: 104.00, lon: 99.02024, city: updatedDataSource[indexPath.row]) { (result) in
            switch result {
            case .success(let WeatherData):
                DispatchQueue.main.async {
                    // Uppdatera UI
                    city = WeatherData.name
                    temp = WeatherData.main.temp
                }
            case .failure(let error): print("Error: \(error)")
                }
        }
        
        let alertController = UIAlertController(title: "City:      \(city)",
                                                message: "Temp: \(temp), condition:", preferredStyle: UIAlertController.Style.alert)
        searchController.isActive = false
        // MARK: Flytta värde till favoriter
        let okAction = UIAlertAction(title: "Favorite", style: .default) {
            
            (action:UIAlertAction) in print("You did favorite: \(self.updatedDataSource[indexPath.row])")
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return updatedDataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = updatedDataSource[indexPath.row]
        return cell
    }
}
