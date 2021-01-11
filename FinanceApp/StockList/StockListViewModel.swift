//
//  StockListViewModel.swift
//  FinanceApp
//
//  Created by Bruno Scheltzke on 10/01/21.
//

import Foundation

protocol StockListViewModelDelegate: class {
    func failed(message: String)
    func didGet(_ items: [Symbol])
}

struct StockListViewModel {
    
    weak var delegate: StockListViewModelDelegate?
    let provider: FinanceProvidable
    
    init(provider: FinanceProvidable) {
        self.provider = provider
    }
    
    func searchSymbol(_ symbol: String) {
        provider.searchSymbol(symbol) { result in
            switch result {
            case .failure(let error):
                self.delegate?.failed(message: error.localizedDescription)
            case .success(let items):
                self.delegate?.didGet(items)
            }
        }
    }
    
}
