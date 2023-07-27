//
//  ViewController.swift
//  Clovity-CodeAssessment
//
//  Created by AnushaValasapalli on 7/26/23.
//

import UIKit
import Combine

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    
    @IBOutlet weak var searchContainerView: UIView!
    
    var filteredCountries: [Country] = []

    var searchController = UISearchController()
     var aryCountries = [Country]()
     var countriesViewModel = CountriesViewModel()

     private var cancellable: AnyCancellable?
    
    @IBOutlet weak var tableVwCountries: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //countriesViewModel.fetchCountries()

        
        tableVwCountries.delegate = self
        tableVwCountries.dataSource = self
        tableVwCountries.register(CountriesTableViewCell.self, forCellReuseIdentifier: "cell")
        tableVwCountries.separatorStyle = .none
        
        searchController = UISearchController(searchResultsController: nil) // Initialize the searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Country"
        
        searchContainerView.addSubview(searchController.searchBar)
        
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = true
        NSLayoutConstraint.activate([
            searchController.searchBar.topAnchor.constraint(equalTo: searchContainerView.topAnchor),
            searchController.searchBar.leadingAnchor.constraint(equalTo: searchContainerView.leadingAnchor),
            searchController.searchBar.trailingAnchor.constraint(equalTo: searchContainerView.trailingAnchor),
            searchController.searchBar.bottomAnchor.constraint(equalTo: searchContainerView.bottomAnchor)
        ])

        
    
    }
    override func viewWillAppear(_ animated: Bool) {
        
        countriesViewModel.fetchCountries()
        
        cancellable = countriesViewModel.$countries
            .sink { [weak self] countries in
                guard let self = self else { return }
                // Do something with the updated 'countries' array
                self.aryCountries = countries
                print("aryCountries:", self.aryCountries)
                tableVwCountries.reloadData()
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return searchController.isActive ? filteredCountries.count : aryCountries.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Countries", for: indexPath) as! CountriesTableViewCell
        let country: Country
        if searchController.isActive {
            country = filteredCountries[indexPath.row]
        } else {
            country = aryCountries[indexPath.row]
        }
        
        cell.nameCountry.text = country.name
        cell.code.text = country.code
        cell.region.text = country.region
        cell.capital.text = country.capital
        cell.vwBg.layer.cornerRadius = 5.0
        return cell
    }

    func updateSearchResults(for searchController: UISearchController) {
        filterCountriesForSearchText(searchController.searchBar.text)
    }
    private func filterCountriesForSearchText(_ searchText: String?) {
        // Perform filtering based on searchText and update your table view accordingly
        if let searchText = searchText, !searchText.isEmpty {
            // Filter the countries based on the search text
            filteredCountries = aryCountries.filter { country in
                return country.name.localizedCaseInsensitiveContains(searchText)
            }
        } else {
            // If the search text is empty, show all countries
            filteredCountries = aryCountries
        }
        // Update the table view with the filtered results
        tableVwCountries.reloadData()
    }
 
 
}
