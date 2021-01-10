//
//  StockListViewModel.swift
//  FinanceApp
//
//  Created by Bruno Scheltzke on 10/01/21.
//

import Foundation

struct StockListViewModel {
    
    let provider: FinanceProvidable
    
    init(provider: FinanceProvidable) {
        self.provider = provider
    }
    
}
