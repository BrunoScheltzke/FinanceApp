//
//  StockListViewController.swift
//  FinanceApp
//
//  Created by Bruno Scheltzke on 10/01/21.
//

import UIKit
import DZNEmptyDataSet

class StockListViewController: BaseViewController {
    
    let tableView = UITableView()
    var items = [String]()
    var viewModel: StockListViewModel
    
    let searchController = SearchController()
    
    init(viewModel: StockListViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationItem.title = "Stocks"
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
    }
    
    private func setupTableView() {
        tableView.constraintFully(to: view)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.emptyDataSetSource = self
    }
    
}

extension StockListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
    }
    
}

extension StockListViewController: UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.selectionStyle = .none
        let item = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "No stock found. Search for a different stock.")
    }
    
}
