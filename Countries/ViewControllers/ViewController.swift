//
//  ViewController.swift
//  Countries
//
//  Created by Kalyan Chakravarthy Narne on 2/27/25.
//

import UIKit
import Combine

class ViewController: UIViewController {
    var countries: [Country] = []
    var allCountries: [Country] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureView()
        configureTableView()
        getItems()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureNavigationBar() {
        title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Set up the search controller
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        tableView.dataSource = self
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifiers.countryTableViewCell)
    }
    
    private var cancellables = Set<AnyCancellable>()
    private func getItems() {
        ViewModel()
            .getCountries()
            .receive(on: DispatchQueue.main) // Receive the results on the main thread
            .sink(receiveValue: { [weak self] countries in
                self?.countries = countries
                self?.allCountries = countries
                self?.tableView.reloadData()
            })
            .store(in: &cancellables) // Store the cancellable to manage the subscription
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifiers.countryTableViewCell, for: indexPath) as? CountryTableViewCell else {
            return UITableViewCell()
        }
        cell.layer.borderColor = UIColor.black.cgColor
        cell.setUp(with: countries[indexPath.row])
        return cell
    }
}



extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterItems(with: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        filterItems(with: "")
        searchBar.resignFirstResponder()
    }
    
    private func filterItems(with searchText: String) {
        if searchText.isEmpty {
            countries = allCountries
        } else {
            countries = allCountries.filter { country in
                return country.name?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
        tableView.reloadData()
    }
}
