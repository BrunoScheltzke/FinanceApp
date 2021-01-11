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
    var items = [Symbol]()
    var viewModel: StockListViewModel
    
    let searchController = SearchController()
    
    init(viewModel: StockListViewModel) {
        self.viewModel = viewModel
        super.init()
        self.viewModel.delegate = self
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

extension StockListViewController: StockListViewModelDelegate {
    
    func failed(message: String) {
        view.unlock()
        present(message: message)
    }
    
    func didGet(_ items: [Symbol]) {
        view.unlock()
        self.items = items
        tableView.reloadData()
    }
    
}

extension StockListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        view.lock()
        viewModel.searchSymbol(text)
        searchController.dismiss(animated: true, completion: nil)
    }
    
}

extension StockListViewController: UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.selectionStyle = .none
        let item = items[indexPath.row]
        cell.textLabel?.text = item.symbol
        cell.detailTextLabel?.text = item.longname
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        let viewModel = ChartViewModel(symbol: item, provider: self.viewModel.provider)
        let viewController = ChartViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "No stock found. Search for a different stock.")
    }
    
}
