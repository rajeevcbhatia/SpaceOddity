//
//  LaunchesViewController.swift
//  SpaceOddity
//
//  Created by Rajeev Bhatia on 07/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit

class LaunchesViewController: BaseViewController {
    
    @IBOutlet weak var launchesTableView: UITableView!
    
    private var allLaunches = [Launch]()
    private var filteredLaunches = [Launch]()
    
    private let searchController = UISearchController(searchResultsController: nil)

    private let listingsService: LaunchesServiceable
    
    required init(service: LaunchesServiceable) {
        self.listingsService = service
        super.init(nibName: String(describing: LaunchesViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        fetchAllLaunches()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupSearchController() {
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.autocorrectionType = .no
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Launches"
        definesPresentationContext = true
        launchesTableView.tableHeaderView = searchController.searchBar
    }
    
    private func fetchAllLaunches() {
        listingsService.fetchLaunches { [weak self] (result) in
            guard let self = self, let launchesResponse = try? result.get() else { return }
            
            self.allLaunches = launchesResponse.launches
            self.launchesTableView.reloadData()
        }
    }
}

extension LaunchesViewController: UITableViewDataSource, UITableViewDelegate {
    
    var launchesDataSource: [Launch] {
        return isFiltering ? filteredLaunches : allLaunches
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launchesDataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}

extension LaunchesViewController: UISearchResultsUpdating {
    
    var searchBarIsEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
}
