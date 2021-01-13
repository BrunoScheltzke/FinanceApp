//
//  ScheltzkeFinanceProvider.swift
//  FinanceApp
//
//  Created by Bruno Scheltzke on 13/01/21.
//

import Foundation

class ScheltzkeFinanceProvider: FinanceProvidable {
    
    func getFinanceData(symbol: String, dateInterval: DateInterval, completion: @escaping (Result<([ChartEntry], StockDetail), Error>) -> Void) {
        let details = StockDetail(open: "0.89", high: "0.91", low: "0.85", volume: "800")
        let entries = [
            ChartEntry(price: 841.5900268554688, dateIndicator: 1610461800.0),
            ChartEntry(price: 838.8468017578125, dateIndicator: 1610462100.0),
            ChartEntry(price: 845.6799926757812, dateIndicator: 1610462400.0),
            ChartEntry(price: 845.8472900390625, dateIndicator: 1610462700.0),
            ChartEntry(price: 842.6199951171875, dateIndicator: 1610463000.0),
            ChartEntry(price: 848.780029296875, dateIndicator: 1610463300.0),
            ChartEntry(price: 849.8280029296875, dateIndicator: 1610463600.0),
            ChartEntry(price: 849.9299926757812, dateIndicator: 1610463900.0),
            ChartEntry(price: 856.6799926757812, dateIndicator: 1610464200.0),
            ChartEntry(price: 860.0999755859375, dateIndicator: 1610464500.0),
            ChartEntry(price: 859.419921875, dateIndicator: 1610464800.0)
        ]
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(.success((entries, details)))
        }
    }
    
    func searchSymbol(_ symbol: String, completion: @escaping (Result<[Symbol], Error>) -> Void) {
        let symbols = [
            Symbol(symbol: "AAPL", longname: "Apple Inc."),
            Symbol(symbol: "APLE", longname: "Appl, Hospitality REIT, Inc."),
            Symbol(symbol: "AAPL.MX", longname: "Apple Inc."),
            Symbol(symbol: "APRU", longname: "Appl, Rush Company, Inc."),
            Symbol(symbol: "APC.F", longname: "Apple Inc."),
            Symbol(symbol: "APC.DE", longname: "Apple Inc."),
            Symbol(symbol: "AAPL.BA", longname: "Apple Inc.")
        ]
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(.success(symbols))
        }
    }
    
    func getRiskReturn(stock: String, startDate: Date, endDate: Date, completion: @escaping(Result<String, Error>) -> Void) {
        completion(.success("Geez, that is way too risky. Don't do it!"))
    }
    
}
