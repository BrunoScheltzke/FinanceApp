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
    
    init(provider: FinanceProvidable) {
        self.provider = provider
    }
    
    func getItens() {
        provider.getFinanceData { result in
            switch result {
            case .success(let entries):
                self.delegate?.didGet(entries)
            case .failure(let error):
                self.delegate?.failed(message: error.localizedDescription)
            }
        }
    }
    
}
