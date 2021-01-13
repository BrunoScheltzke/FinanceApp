//
//  FinanceAPIProvidable.swift
//  FinanceApp
//
//  Created by Bruno Scheltzke on 13/01/21.
//

import Foundation

protocol FinanceProvidable {
    func getFinanceData(symbol: String, dateInterval: DateInterval, completion: @escaping(Result<([ChartEntry], StockDetail), Error>) -> Void)
    func searchSymbol(_ symbol: String, completion: @escaping(Result<[Symbol], Error>) -> Void)
    func getRiskReturn(stock: String, startDate: Date, endDate: Date, completion: @escaping(Result<String, Error>) -> Void)
}
