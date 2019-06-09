//
//  LaunchesViewController.swift
//  SpaceOddity
//
//  Created by Rajeev Bhatia on 07/06/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit

class LaunchesViewController: BaseViewController {
    
    @IBOutlet weak var launchesTableView: UITableView! {
        didSet {
            launchesTableView.estimatedRowHeight = 200.0
            launchesTableView.dataSource = self
            launchesTableView.delegate = self
            launchesTableView.register(UINib(nibName: LaunchTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: LaunchTableViewCell.reuseIdentifier)
        }
    }
    
    private var allLaunches = [Launch]()
    var filteredLaunches = [Launch]() //this is not made private for testing. alternate approach to this could be to also make a dependency injectable for the searchController so that the "isActive" can be mocked and "isFiltering" can also be used in tests
    
    private let searchController = UISearchController(searchResultsController: nil)

    private let launchesService: LaunchesServiceable
    
    required init(service: LaunchesServiceable) {
        self.launchesService = service
        super.init(nibName: String(describing: LaunchesViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        setupSearchController()
        fetchAllLaunches()
    }
    
    override func initNotificationObservers() {
        super.initNotificationObservers()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyBoardWillShow(notification: NSNotification) {
        if let keyBoardSize = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect {
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyBoardSize.height, right: 0)
            launchesTableView.contentInset = contentInsets
        }
    }
    
    @objc func keyBoardWillHide(notification: NSNotification) {
        launchesTableView.contentInset = UIEdgeInsets.zero
    }
    
    private func setupSearchController() {
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.autocorrectionType = .no
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Launches"
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
    }
    
    private func fetchAllLaunches() {
        showLoader()
        launchesService.fetchLaunches { [weak self] (result) in
            guard let self = self else { return }
            
            self.hideLoader()
            
            guard let launchesResponse = try? result.get() else {
                self.showRetry()
                return
                
            }
            
            self.allLaunches = launchesResponse.launches
            DispatchQueue.main.async { [weak self] in
                self?.launchesTableView.reloadData()
            }
            
        }
    }
    
    private func showRetry() {
        showRetryAlert(title: "Could not fetch details.", message: "Please retry") { [weak self] in
            self?.fetchAllLaunches()
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LaunchTableViewCell.reuseIdentifier, for: indexPath) as? LaunchTableViewCell else { return UITableViewCell() }
        
        cell.launch = launchesDataSource[indexPath.row]
        cell.nameLabel.text = "\(indexPath.row) " + (cell.nameLabel.text ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
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
        didSearch(query: searchController.searchBar.text ?? "")
    }
    
    func didSearch(query: String) {
        filteredLaunches = allLaunches.filter { $0.missionName.lowercased().contains(query.lowercased()) }
        launchesTableView.reloadData()
    }
    
}
