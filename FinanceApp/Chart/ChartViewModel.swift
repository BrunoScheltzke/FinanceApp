//
//  ChartViewModel.swift
//  FinanceApp
//
//  Created by Bruno Scheltzke on 10/01/21.
//

import Foundation

protocol ChartViewModelDelegate: class {
    func failed(message: String)
    func didGet(_ item: ([ChartEntry], StockDetail))
    func didGet(riskReturn: String)
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
            case .success(let item):
                self.delegate?.didGet(item)
            case .failure(let error):
                self.delegate?.failed(message: error.localizedDescription)
            }
        }
    }
    
    func getRiskReturn(startDate: Date, endDate: Date) {
        provider.getRiskReturn(stock: symbol.symbol, startDate: startDate, endDate: endDate) { result in
            switch result {
            case .success(let response):
                self.delegate?.didGet(riskReturn: response)
            case .failure(let error):
                self.delegate?.failed(message: error.localizedDescription)
            }
        }
    }
    
}
