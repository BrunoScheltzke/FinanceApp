//
//  ChartViewModel.swift
//  FinanceApp
//
//  Created by Bruno Scheltzke on 10/01/21.
//

import Foundation

protocol ChartViewModelDelegate: class {
    func failed(message: String)
    func didGet(_ items: [ChartEntry])
}

struct ChartViewModel {
    
    weak var delegate: ChartViewModelDelegate?
    let provider: FinanceProvidable
    let symbol: Symbol
    
    init(symbol: Symbol, provider: FinanceProvidable) {
        self.symbol = symbol
        self.provider = provider
    }
    
    func getItens() {
        provider.getFinanceData(symbol: symbol.symbol, dateInterval: .oneMonth) { result in
            switch result {
            case .success(let entries):
                self.delegate?.didGet(entries)
            case .failure(let error):
                self.delegate?.failed(message: error.localizedDescription)
            }
        }
    }
    
}
